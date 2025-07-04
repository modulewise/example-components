#![no_main]

wit_bindgen::generate!({
    path: "../wit",
    world: "greeter-world",
    generate_all
});

struct Greeter;

impl exports::modulewise::example_components::greeter::Guest for Greeter {
    fn greet(name: String) -> String {
        format!("Hello {name}!")
    }
}

export!(Greeter);
