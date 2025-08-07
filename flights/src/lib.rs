#![no_main]

use exports::modulewise::example_components::flights;
use modulewise::example_components::rest_client;

wit_bindgen::generate!({
    path: "../wit",
    world: "flights-world",
    generate_all,
    additional_derives: [serde::Serialize, serde::Deserialize],
});

struct Flights;

impl Flights {
    fn base_url() -> String {
        wasi::config::store::get("base_url")
            .ok()
            .flatten()
            .unwrap_or("http://localhost:8080".to_string())
    }
}

impl flights::Guest for Flights {
    fn get_flights() -> String {
        let url = format!("{}/flights", Self::base_url());
        match rest_client::get(&url, &[]) {
            Ok(response) => response,
            Err(e) => format!("{{\"error\": \"{e}\"}}"),
        }
    }

    fn get_flight_by_id(id: String) -> String {
        let url = format!("{}/flights/{id}", Self::base_url());
        match rest_client::get(&url, &[]) {
            Ok(response) => response,
            Err(e) => format!("{{\"error\": \"{e}\"}}"),
        }
    }

    fn search_flights(data: flights::FlightSearch) -> String {
        let url = format!("{}/flights/search", Self::base_url());
        let json = serde_json::to_string(&data).unwrap_or_default();
        let headers = vec![("Content-Type".to_string(), "application/json".to_string())];
        match rest_client::post(&url, &headers, &json) {
            Ok(response) => response,
            Err(e) => format!("{{\"error\": \"{e}\"}}"),
        }
    }
}

export!(Flights);
