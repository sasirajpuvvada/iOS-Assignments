import Foundation
var instImplementation = Implemtation()
var instError = ErrorHandling()
func AddUserDetails(){
    instError.errorCheck()
}
func DeleteUserDetails()
{
    print("Enter the roll no of the student")
    if let k = readLine(){
        if let p = Int(k) {
            let flag = instImplementation.deleteDetails(p)
            if flag == 0{
                DisplayUserDetails()
                print("details of \(p) is deleted")
            }
            else{
                print("roll no \(p) doesn't exist")
            }
        }
    }
}

func DisplayUserDetails(){
    let instSorting = Sorting()
    instSorting.choice()
    
}
var op = "y"
repeat{
    print("1.Add Student Details")
    print("2.Display User Details")
    print("3.Delete User Details")
    print("4.Exit")
    if let toption = readLine(){
        if let option = Int(toption)
        {
            switch option {
            case 1:  AddUserDetails();
            case 2:  DisplayUserDetails();
            case 3:  DeleteUserDetails();
            case 4:  op = "n"
            default: op = "n"
                print("Wrong option")
            }
        }
        else
        {
            print("Wrong input")
        }
    }
}while(op == "y")

