import Foundation

var option = "y"
var ar = [ItemDetails]()
func add_items()
{
    let err = Parser()
    
    do{
        let items = try err.check_items()
        let itemAdd = (ItemDetails(items[0] as! String,items[1] as! Double,items[2] as! Int,items[3] as! String))
        itemAdd.calculateTax()
        ar.append(itemAdd)
    }catch Errors.noinput{
        print("No input is given")
    }catch Errors.notValidType{
        print("type should be from \(err.types)")
    }catch Errors.nonInteger{
        print("The Value should be Integer")
    }catch Errors.nonDouble{
        print("The value should bee double")
    }catch{
        print("Other Errors")
    }
    
}

func display_items()
{
    print("--------------------------------------------")
    print("item-name item-price item-quantity item-type total-price")
    for i in ar{
        print(i.item_name , terminator: "    ")
        print(i.item_price, terminator: "       ")
        print(i.item_quantity, terminator: "      ")
        print(i.item_type, terminator: "      ")
        print(i.item_tax + i.item_price)
    }
    print("--------------------------------------------")
}

repeat
{
    print("1.Add Items")
    print("2.Display items")
    print("3.exit")
    var choice:Int?
    if let tchoice = readLine(){
        choice = Int(tchoice)
    }
    switch choice! {
    case 1: add_items()
    case 2: display_items()
    case 3: break
    default:print("Wrong option") ; break
    }
    print("do you want to continue")
    if let temp = readLine()
    {
        option = temp
    }
    
}while(option=="y" || option=="Y")
