Задача 1. Установите golang  
lianast11@Liudmilas-MBP ~ % go version  
go version go1.18.2 darwin/amd64  
lianast11@Liudmilas-MBP ~ %   

Задача 2. Знакомство с gotour  

Задача 3. Написание кода  

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:
~~~
package main
    
    import "fmt"
    
    import "math"
    
    func main() {
        fmt.Print("Enter value in foot: ")
        var input float64
        
        fmt.Scanf("%f", &input)               
        output := input * float64(0.3048)      
        RoundOutput := math.Round(output)         
        SprintfOutput := fmt.Sprintf("( %.2f)", output)
        fmt.Println("Meters:", RoundOutput, SprintOutput )    
    }  
}
~~~

2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}

    package main

    import "fmt"

    func main() {

        x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}

        mini := x[0]

        length := len(x)

            for i := 0; i<length; i = i+1 {

                if x[i] < mini {
                mini = x[i]
                }
            }
        fmt.Println(mini)
    } 

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).
   ~~~
    package main

    import "fmt"

    func Details ()(List []int) {
	    for i := 1;  i <= 100; i ++ {
		    if	i % 3 == 0 { 
			    List = append(List, i)
		    }
	    }	
	    return
    }
    

    func main() {
	    toPrint := Details()
	    fmt.Printf("Numbers: %v\n", toPrint)
    }
    ~~~
