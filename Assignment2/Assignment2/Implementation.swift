import Foundation
//var arrStudent = [Student]()
class Implemtation {
    var name : String?
    var address : String?
    var age : Int?
    var avaCourses = ["A","B","C","D","E","F"]
    var courses : Set<String> = []
    var rollno : Int?
    let k = ErrorHandling()
    //let student = Student()
    var item = [Any]()
    func addDetails(_ instStudent: [Student]) throws -> [Any]{
        item.removeAll()
        print("Enter The name of the Student")
        guard let tname = readLine() else {
            throw Errors.noinput
        }
        item.append(tname)
        
        print("Enter Address")
        guard  let tadd = readLine() else {
            throw Errors.noinput
        }
        item.append(tadd)
        
        print("Enter the age of the Student")
        guard let tage = readLine() else {
            throw Errors.noinput
        }
        guard let tage1 = Int(tage) else {
            throw Errors.nonString
        }
        item.append(tage1)
        
        print("Enter Courses")
        print("Avaliable Courses A B C D E F\nchoose any four Course")
        var count = 4
        while count>0 {
            print("Enter course\(4-count+1)")
            let c = readLine()
            let t = c!.uppercased()
            if(avaCourses.contains(t))
            {
                if(courses.contains(t))
                {
                    print("This course is already Selected choose another course")
                }
                else {
                    courses.insert(t)
                    count = count - 1
                }
            } else {
                print("course in not avaliable")
            }
        }
        item.append(courses)
        courses.removeAll()
        print("Enter roll no:")
        guard let trollno = readLine() else {
            throw Errors.noinput
        }
        guard let trollno1 = Int(trollno) else {
            throw Errors.nonInteger
        }
        var f = 1
        for val in stu{
            if(val.getRollNo() == trollno1){
                print(val.getRollNo())
                f = 0
                break
            }
        }
        if(f==1){
            item.append(trollno1)
        }
        else{
            print("Roll no is already existing")
            item.removeAll()
        }
        print(item.count)
        return item
    }
    
//    func displayDetail(){
//        let instStudent = k.getStudentInst()
//        for val in instStudent{
//    print(val.getName(), val.getAddress(), val.getAge(), val.getCourses(), val.getRollNo())
//        }
//    }
    
//    func displayDetails() {
//        let instStudent = k.getStudentInst()
//        print("1. sort using rollno")
//        print("2. sort using name")
//        print("3. sort using age")
//        print("4. sort using address")
//        print("5. sort using rollno (DESC)")
//        print("6. sort using name (DESC)")
//        print("7. sort using age (DESC)")
//        print("8. sort using address (DESC)")
//        if let k = readLine() {
//            if let p = Int(k), p<9 {
//                let instSort = Sorting()
//                switch p {
//                case 1:
//                default:
//                    <#code#>
//                }
//            }
//        }
//    }
    
    
    func deleteDetails(_ roll: Int) -> Int {
        var instStudent = k.getStudentInst()
        var flag = 1
        for (index,val) in instStudent.enumerated(){
            if val.getRollNo() == roll {
                flag = 0
                instStudent.remove(at: index)
            }
        }
        return flag
    }
}
