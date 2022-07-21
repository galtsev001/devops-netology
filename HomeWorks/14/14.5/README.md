## 14.5 SecurityContext, NetworkPolicies
___
#### Задача 1: Рассмотрите пример 14.5/example-security-context.yml

+ Создайте модуль

![img.png](./img/1.png)

```shell
kubectl apply -f 14.5/example-security-context.yml
```
+ Проверьте установленные настройки внутри контейнера

![img.png](./img/2.png)

```shell
kubectl logs security-context-demo
uid=1000 gid=3000 groups=3000
```
___
#### Задача 2 (*): Рассмотрите пример 14.5/example-network-policy.yml
Создайте два модуля. Для первого модуля разрешите доступ к внешнему миру и ко второму контейнеру. Для второго модуля разрешите связь только с первым контейнером. Проверьте корректность настроек.

+ Создадим тестовый `namespace`

![img.png](./img/3.png)

+ Создадим конфиг файлы для создания двух модулей [first-app.yaml](config/first-app.yaml) и [second-app.yaml](./config/second-app.yaml)

![img.png](./img/4.png)

+ Создадим две сетевых политик и сервис для созданных подов
    + [first-policy.yaml](./config/first-policy.yaml)
    + [second-policy.yaml](./config/second-policy.yaml)
    + [service.yaml](./config/service.yaml)

![img.png](./img/5.png)

**Проверяем что сделано все согласно требованиям**

+ Исходящий доступ от `first-app`

![img.png](./img/6.png)

+ Отсутствует исходящий доступ от `second-app`:

![img.png](./img/7.png)

+ Доступ от `first-app` к `second-app`:

![img.png](./img/8.png)

+ Отсутствует доступ от `second-app` к `first-app`:

![img.png](./img/9.png)
