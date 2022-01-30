# Домашнее задание к занятию "09.02 CI\CD"

## Знакомоство с SonarQube

### Подготовка к выполнению

1. Выполняем `docker pull sonarqube:8.7-community`
2. Выполняем `docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:8.7-community`
3. Ждём запуск, смотрим логи через `docker logs -f sonarqube`
4. Проверяем готовность сервиса через [браузер](http://localhost:9000)
5. Заходим под admin\admin, меняем пароль на свой

В целом, в [этой статье](https://docs.sonarqube.org/latest/setup/install-server/) описаны все варианты установки, включая и docker, но так как нам он нужен разово, то достаточно того набора действий, который я указал выше.

### Основная часть

1. Создаём новый проект, название произвольное
2. Скачиваем пакет sonar-scanner, который нам предлагает скачать сам sonarqube
3. Делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)
4. Проверяем `sonar-scanner --version`
5. Запускаем анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`
6. Смотрим результат в интерфейсе
7. Исправляем ошибки, которые он выявил(включая warnings)
8. Запускаем анализатор повторно - проверяем, что QG пройдены успешно
9. Делаем скриншот успешного прохождения анализа, прикладываем к решению ДЗ

## Знакомство с Nexus

### Подготовка к выполнению

1. Выполняем `docker pull sonatype/nexus3`
2. Выполняем `docker run -d -p 8081:8081 --name nexus sonatype/nexus3`
3. Ждём запуск, смотрим логи через `docker logs -f nexus`
4. Проверяем готовность сервиса через [бразуер](http://localhost:8081)
5. Узнаём пароль от admin через `docker exec -it nexus /bin/bash`
6. Подключаемся под админом, меняем пароль, сохраняем анонимный доступ

### Основная часть

1. В репозиторий `maven-public` загружаем артефакт с GAV параметрами:
    1. groupId: netology
    2. artifactId: java
    3. version: 8_282
    4. classifier: distrib
    5. type: tar.gz
2. В него же загружаем такой же артефакт, но с version: 8_102
3. Проверяем, что все файлы загрузились успешно
4. В ответе присылаем файл `maven-metadata.xml` для этого артефекта

### Знакомство с Maven

### Подготовка к выполнению

1. Скачиваем дистрибутив с [maven](https://maven.apache.org/download.cgi)
2. Разархивируем, делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)
3. Проверяем `mvn --version`
4. Забираем директорию [mvn](./mvn) с pom

### Основная часть

1. Меняем в `pom.xml` блок с зависимостями под наш артефакт из первого пункта задания для Nexus (java с версией 8_282)
2. Запускаем команду `mvn package` в директории с `pom.xml`, ожидаем успешного окончания
3. Проверяем директорию `~/.m2/repository/`, находим наш артефакт
4. В ответе присылаем исправленный файл `pom.xml`

---
**Ответ**

1. Создаем 2 VM
   ![img.png](./img/1.png)
2. Запускаем подготовленный playbook. В конце работы проверяем доступность сервисов SonarQube (<IP>:9000) и Nexus (<IP>:8081)
#### SonarQube   
![img.png](./img/2.png)
#### Nexus
![img.png](./img/3.png)
3. Начнем работу с `SonarQube`. Скачаем агента на компьютер и установим `PATH`
   ![img.png](./img/4.png)
4. Создадим проект в SonarQube и подключимся к нему
   ![img.png](./img/5.png)
5. Запускаем анализ кода и видим 3 предупреждения
   ![img.png](./img/6.png)
6. Исправляем замечания 
```python
def increment(index):
    return index + 1
	
def get_square(numb):
    return numb*numb
	
def print_numb(numb):
    print("Number is {}".format(numb))

index = 0
while (index < 10):
    index = increment(index)
    print(get_square(index))
```
7. Проверяем скрипт, что он работает после исправления

   ![img.png](./img/7.png)
8. Смотрим что нам покажет SonarQube
   ![img.png](./img/8.png)

#### Nexus

9. Nexus загружаем требуемые файлы
   ![img.png](./img/9.png)
10. Файл maven-metadata.xml

 [maven-metadata.xml](./config/maven-metadata.xml)

#### Maven

11. Устанавливаем Maven

![img.png](./img/10.png)

12. Получаем файл pom.xml

[pom.xml](./config/pom.xml)

13. результат в Nexus

![img.png](./img/11.png)




