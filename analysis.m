import matlab.net.*
import matlab.net.http.*

% Request data from C# server
[response] = send(RequestMessage, URI("http://localhost:5000"));

% Convert the data from JSON to a MATLAB struct
data = jsondecode(convertCharsToStrings(native2unicode(response.Body.Data)));

% Wow! We have data now!
data