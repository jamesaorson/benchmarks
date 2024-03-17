#[macro_use] extern crate rocket;

use rocket::config::LogLevel;

#[cfg(test)] mod tests;

#[get("/")]
fn hello() -> &'static str {
    "hello"
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .configure(rocket::Config::figment()
            .merge(("port", 8080))
            .merge(("log_level", LogLevel::Off)))
        .mount("/", routes![hello])
}
