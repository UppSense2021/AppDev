//
//  BLEController.swift
//  UppSense
//
//  Created by Jayendra Prashanth on 16/06/21.
//

import Foundation
import CoreBluetooth

struct resultMsg {
    var result: String
    var biosensorID: String
    var testID: String
    var date: String
    var time: String
}

class BLEController: NSObject, ObservableObject, CBPeripheralManagerDelegate
{
    @Published var peripheralManager: CBPeripheralManager!
    @Published var BLEon = false
    @Published var Result = ""
    @Published var showAlert = false //State var to show alert When a result arises
    @Published var currentResultMsg: resultMsg!
    
    //@Published var peripheralUUID = CBUUID()
    @Published var peripheralUUID = CBUUID(string: "a5089693-697f-45a7-a229-55d37e1573ee") /* Use this UUID one the pairing device to connect to the app */
    let characteristicUUID = "b548b211-0ed7-4042-aa1c-cab3126afce3" /* UUID for recieving H1N1 Result */
    var service: CBMutableService?
    
    override init() {
        super.init()

        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        peripheralManager.delegate = self
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if (peripheral.state == .poweredOn) {
            BLEon = true
            self.service = CBMutableService(type: peripheralUUID, primary: true)
        } else {
            print("Bluetooth not powered on!")
            return
        }
        
        let characteristic = CBMutableCharacteristic.init(
            type: CBUUID(string: "A5089693-697F-45A7-A229-55D37E1573EE"),
            properties: [.write],
            value: nil,
            permissions: [CBAttributePermissions.writeable])
        
        self.service?.characteristics = []
        self.service?.characteristics?.append(characteristic)
        self.peripheralManager.add(self.service!)
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
         if let error = error {
            print("Add service failed: \(error.localizedDescription)")
            return
        }
        print("Add service succeeded")
        
        peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey: "UppSense Patient",
                                            CBAdvertisementDataServiceUUIDsKey : [self.service!.uuid]])
    }

    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("Start advertising failed: \(error.localizedDescription)")
            return
        }
        print("Start advertising succeeded")
    }
    
    // Called when receiving writing from Central.
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        print("didReceiveWrite requests")
                
        //Recieve data
        let request = requests.last!
        self.Result = String.init(data: request.value!, encoding: String.Encoding.utf8) ?? ""
        
        print(self.Result)
        
        // String will be recieved in format Positive$BiosensorID$TestID$Date$Time
        let result_str_array = self.Result.components(separatedBy: "+")
        currentResultMsg = resultMsg(result: result_str_array[0], biosensorID: result_str_array[1],
                                     testID: result_str_array[2], date: result_str_array[3], time: result_str_array[4])
        showAlert = true // Show alert message
            
        // Send response to central if this writing request asks for response [.withResponse]
        print("Sending response: Success")
        peripheral.respond(to: request, withResult: .success)
    }
}

func ble_in_test() {
    let str = "Positive$KA70$3763$8th September 2012$17:20 CET"
    let str_array = str.components(separatedBy: "$")
    print(str_array[0])
    print(str_array[1])
    print(str_array[2])
    print(str_array[3])
    print(str_array[4])
}
