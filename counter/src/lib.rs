#![no_main]

wit_bindgen::generate!({
    path: "../wit",
    world: "counter-world",
    generate_all
});

struct Counter;

impl exports::modulewise::example_components::counter::Guest for Counter {
    fn count(thing: String) -> String {
        let c = modulewise::example_components::incrementor::increment(&thing).unwrap_or(0);
        let t = if c == 1 { thing } else { format!("{thing}s") };
        let s = wasi::config::store::get("suffix")
            .ok()
            .flatten()
            .unwrap_or("!".to_string());
        format!("{c} {t} {s}")
    }
}

export!(Counter);
