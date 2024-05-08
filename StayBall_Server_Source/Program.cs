// Setting the windows version:
// Go to 'StayBall Server.csproj'
// Edit <TargetFramework>net8.0-windows10.0.22000.0</TargetFramework>
// and replace the windows10.0.22000.0 with right windows version

using System.Net;
using System.Text.Json;
using System.Text;
using Windows.Devices.Sensors;
using Windows.Foundation;
using System.Diagnostics;

class Program {
    // Sample rate of the accelerometer in millis
    const uint ACCELEROMETER_POLL_INTERVAL = 1000 / 25;

    static Accelerometer accelerometer = Accelerometer.GetDefault();

    // The structure that contains the data you need in matlab for analysis
    class Data {
        public Data(double x, double y, double z) {
            X = x;
            Y = y;
            Z = z;
        }

        // Add whatever fields you actually need
        public double X { get; }
        public double Y { get; }
        public double Z { get; }
    }

    // Listen for data requests and respond with data
    static void Main() {
        EnableAccelerometer();
        RunServer();
    }

    // Try to enable the accelerometer if there is one.
    static void EnableAccelerometer()
    {
        // Establish the report interval
        accelerometer.ReportInterval = ACCELEROMETER_POLL_INTERVAL;
        accelerometer.ReadingChanged += new TypedEventHandler<Accelerometer, AccelerometerReadingChangedEventArgs>(ReadingChanged);
    }

    static void RunServer() {
        HttpListener listener = new HttpListener();
        // This sets the URL that MATLAB will use to request data
        string listeningAddress = "http://localhost:5000/";
        listener.Prefixes.Add(listeningAddress);
        listener.Start();
        Console.WriteLine("Server started and waiting for accelerometer requests from " + listeningAddress + ".");
        Stopwatch stopWatch = new Stopwatch();
        while (listener.IsListening) {
            // Wait for a request
            HttpListenerContext context = listener.GetContext();

            stopWatch.Reset();
            stopWatch.Start(); 
            
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;
            
            // Get the current data
            Data data = GetData();

            // Convert it to a format we can send over HTTP. This format is called "JSON".
            // The process of converting to JSON is called "Serialization".
            // Undoing it is called "Deserialization".
            string json = JsonSerializer.Serialize(data);
            
            // Put our JSON data in the response and send it to MATLAB
            byte[] buffer = Encoding.UTF8.GetBytes(json);
            response.ContentLength64 = buffer.Length;
            response.OutputStream.Write(buffer, 0, buffer.Length);
            response.OutputStream.Close();
            stopWatch.Stop();

            Console.WriteLine("Took " + stopWatch.ElapsedMilliseconds + " millis to resolve request. X:" + data.X + " Y:" + data.Y + " Z:" + data.Z);
        }
    }

    static Mutex readingMutex = new Mutex();
    static AccelerometerReading reading = accelerometer.GetCurrentReading();

    // Get the current data from the accelerometer
    static Data GetData() {
        readingMutex.WaitOne();
        Data data = new Data(reading.AccelerationX, reading.AccelerationY, reading.AccelerationZ);
        readingMutex.ReleaseMutex();
        return data;
    }

    static void ReadingChanged(object sender, AccelerometerReadingChangedEventArgs e) {
        readingMutex.WaitOne();
        reading = e.Reading;
        readingMutex.ReleaseMutex();
    }
}