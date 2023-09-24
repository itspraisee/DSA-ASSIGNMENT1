import ballerina/grpc;
import ballerina/io;
type LibraryServiceClient record {
    
};

LibraryServiceClient ep = check new ("http://localhost:9090");


    // Implement user interaction and make gRPC calls as needed.
    // For example, you can use io:println and io:readLine for user input and feedback.

    // Example: Add a book.
    library:Book book = {
        title: "Sample Book",
        author_1: "Author A",
        location: "Shelf 1",
        isbn: "1234567890",
        available: true
    };
    string isbn = check clientEndpoint->add_book(book);

    // Example: List available books.
    library:User user = { user_id: 1, user_type: "student" };
    stream<library:Book> availableBooks = check clientEndpoint->list_available_books(user);
    foreach var book in availableBooks {
        io:println("Title: " + book.title + ", ISBN: " + book.isbn);
    }

    // Implement other operations similarly.
}
