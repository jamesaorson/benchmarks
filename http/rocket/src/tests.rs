use rocket::local::blocking::Client;
use rocket::http::{RawStr, Status};

#[test]
fn hello() {
    let client = Client::tracked(super::rocket()).unwrap();
    let mut uri = String::new();
    uri.push_str("/");
    let response = client.get(uri).dispatch();
    assert_eq!(response.into_string().unwrap(), expected);
}
