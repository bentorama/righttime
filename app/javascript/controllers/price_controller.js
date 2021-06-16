import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["drop"]

  connect() {
    console.log('Hello!');
    console.log(this.dropTarget);
  }
}