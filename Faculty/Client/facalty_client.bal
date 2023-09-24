import ballerina/http;

type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    Course[] courses;
};

type Course record {
    string courseName;
    string courseCode;
    string nqfLevel;
};

public function main() {

    http:Client facultyClient = new http:Client("http://localhost:8080");

    var response = facultyClient->get("/faculty/lecturers");
    if (response is http:Response) {
        match response.getJsonArray() {
            json[]|error lecturersArray => {
                if (lecturersArray is json[]) {
                    io:println("List of all lecturers:");
                    foreach var lecturer in lecturersArray {
                        io:println(lecturer.toString());
                    }
                } else {
                    io:println("Error: " + lecturersArray.toString());
                }
            }
        }
    } else {
        io:println("Error: " + response.toString());
    }

    // Close the HTTP client.
    facultyClient->close();
}
