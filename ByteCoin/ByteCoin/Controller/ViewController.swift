

import UIKit

class ViewController: UIViewController{

    var coinManager = CoinManager()

    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }

}

extension ViewController: CoinManagerDelegate{
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
                    self.bitcoinLabel.text = price
                    self.currencyLabel.text = currency
                }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for:coinManager.currencyArray[row])
     
    }
}

