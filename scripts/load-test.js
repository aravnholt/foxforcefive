import { check, sleep } from "k6";
import http from "k6/http";

export let options = {
    stages: [
        { duration: "600s", target: 10 }
    ]
};

export default function() {
    var r = http.get("https://openhackzkr4erh7userprofile-staging.azurewebsites.net/api/healthcheck/user");
    check(r, {
        "status is 200": (r) => r.status === 200
    });
    sleep(1);
}