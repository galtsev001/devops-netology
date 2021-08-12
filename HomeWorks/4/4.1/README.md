## 4.1. Командная оболочка Bash: Практические навыки

#### 1) Есть скрипт:

```bash
    a=1
    b=2
    c=a+b
    d=$a+$b
    e=$(($a+$b))
```
+ Какие значения переменным c,d,e будут присвоены?
+ Почему?

***Ответ:***

```bash
c = a+b # c=a+b <- Здесь, нет экранирование, bash сохранил все как строку
d = 1+2 # d=$a+$b <- Здесь, символом $ мы раскрыли значения переменных, но они были приняты как строка
e = 3   # e=$(($a+$b)) <-Получили результат сложения наших переменных, потому что есть экранирования
```

#### 2) На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным. В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:

```bash
    while ((1==1)
    do
    curl https://localhost:4757
    if (($? != 0))
    then
    date >> curl.log
    fi
    done
```

***Ответ:***

```bash
while ((1==1))  
do  
curl https://localhost:4757  
if (($? != 0))  
then  
date >> curles.log  
else  
break 2  
fi  
sleep 10
done 
```

+ Была пропущена скобка `while ((1==1)` => `while ((1==1))
+ В случае успеха, выйдем из цикла, добавил `break 2` 
+ Чтобы не "захламлять" лог файл в случае ошибки, проверку будем проводить с задержкой в 10 секунд `sleep 10`

#### 3) Необходимо написать скрипт, который проверяет доступность трёх IP: 192.168.0.1, 173.194.222.113, 87.250.250.242 по 80 порту и записывает результат в файл log. Проверять доступность необходимо пять раз для каждого узла.

***Ответ:***

```bash
#!/bin/bash 

#Инициализируем массив с нашими IP  
listIps=(192.168.0.1 173.194.222.113 87.250.250.242)  
#Запускаем цикл для проверки доступности  
for i in {1...5}  
do  
    for ip in ${listIps[@]}  
    do  
        date=$(date)  #Зафиксируем время опроса
        curl --connect-timeout 1 $ip:80  #Проверяем доступность
        if (($?==0))  
            then  
                result=0  
            else  
                result=error  
        fi  
            echo $date $ip status=$result >> request.log  #Пишем результат в лог файл
    done  
done  
```

#### 4) Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается

***Ответ:***

```bash
#!/bin/bash 

#Инициализируем массив с нашими IP  
listIps=(192.168.0.1 173.194.222.113 87.250.250.242)  
#Запускаем цикл для проверки доступности  
for i in {1...5}  
do  
    for ip in ${listIps[@]}  
    do  
        date=$(date)  #Зафиксируем время опроса
        curl -Is --connect-timeout 2 $ip:80  #Проверяем доступность
        if (($? !=0))  
	then  
		date=$(date)  
	        echo $date $ip " is not reachable" >> request.log  #Пишем результат в лог файл
		break 3  
	fi  
    done  
done  
```

