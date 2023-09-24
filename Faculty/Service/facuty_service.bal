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

map<json> lecturersMap = {};

service /faculty on new http:Listener(8080) {

    resource function get getAllLecturers() returns json[] {
        return lecturersMap.values();
    }

    resource function post addLecturer(Lecturer lecturer) returns error? {
        if (lecturersMap.hasKey(lecturer.staffNumber)) {
            return error "Lecturer with the same staff number already exists.";
        }
        lecturersMap[lecturer.staffNumber] = lecturer;
        return ();
    }

    resource function get getLecturerByStaffNumber(string staffNumber) returns json? {
        if (lecturersMap.hasKey(staffNumber)) {
            return lecturersMap[staffNumber];
        }
        return ();
    }

    resource function put updateLecturer(string staffNumber, Lecturer updatedLecturer) returns error? {
        if (lecturersMap.hasKey(staffNumber)) {
            lecturersMap[staffNumber] = updatedLecturer;
            return ();
        }
        return error "Lecturer not found.";
    }

    resource function delete deleteLecturer(string staffNumber) returns error? {
        if (lecturersMap.hasKey(staffNumber)) {
            delete lecturersMap[staffNumber];
            return ();
        }
        return error "Lecturer not found.";
    }

    resource function get getLecturersTeachingCourse(string courseCode) returns json[] {
        json[] lecturers = [];
        foreach var lecturer in lecturersMap.values() {
            foreach var course in lecturer.courses {
                if (course.courseCode == courseCode) {
                    lecturers.push(lecturer);
                    break;
                }
            }
        }
        return lecturers;
    }

    resource function get getLecturersInSameOffice(string officeNumber) returns json[] {
        json[] lecturers = [];
        foreach var lecturer in lecturersMap.values() {
            if (lecturer.officeNumber == officeNumber) {
                lecturers.push(lecturer);
            }
        }
        return lecturers;
    }
}
