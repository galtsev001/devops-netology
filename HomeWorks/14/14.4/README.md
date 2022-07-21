## 14.4 Сервис-аккаунты
___
#### Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube
Выполните приведённые команды в консоли. Получите вывод команд. Сохраните задачу 1 как справочный материал.

+ *Как создать сервис-аккаунт?*

![img.png](./img/1.png)

```bash
kubectl create serviceaccount netology
```
+ *Как просмотреть список сервис-акаунтов?*

![img.png](./img/2.png)

```bash
kubectl get serviceaccounts
kubectl get serviceaccount
```
+ *Как получить информацию в формате YAML и/или JSON?*

![img.png](./img/3.png)

```bash
kubectl get serviceaccount netology -o yaml
kubectl get serviceaccount default -o json
```

+ *Как выгрузить сервис-акаунты и сохранить его в файл?*

![img.png](./img/4.png)

```bash
kubectl get serviceaccounts -o json > serviceaccounts.json
kubectl get serviceaccount netology -o yaml > netology.yml
```

+ *Как удалить сервис-акаунт?*

![img.png](./img/5.png)

```bash
kubectl delete serviceaccount netology
```
+ *Как загрузить сервис-акаунт из файла?*

![img.png](./img/6.png)

```bash
kubectl apply -f netology.yml
```