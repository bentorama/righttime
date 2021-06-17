import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["drop"];

  connect() {
    console.log('Hello!');
    console.log(this.dropTarget);
  }


  refresh() {
    console.log("clicked button")
    fetch('/events', { headers: { accept: "application/json" }
    }).then(response => response.json())
    .then(data => console.log(data))
      }
  }
