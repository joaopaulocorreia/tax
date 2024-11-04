import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "salary" ]
  static values = {
    url: String
  }

  calculate(){
    if(this.salaryTarget.value.length == 0 ){
      return document.getElementById('proponent_tax').setAttribute('value', '')
    }

    const finalUrl = `${this.urlValue}?salary=${this.salaryTarget.value}`

    const response = await fetch(finalUrl)
    const json = await response.json()

    document.getElementById('proponent_tax').setAttribute('value', json)
  }
}
