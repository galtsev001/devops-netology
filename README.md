# My first repo from GitHub

### Описание файла .gitignore в директории terraform
#### 1. Git не будет следить за изменениями (фиксировать) следующие файлы
+ `crash.log`
+ `override.tf`
+ `override.tf.json`
+ `.terraformrc`
+ `terraform.rc`

#### 2. Git не будет следить за изменениями (фиксировать) следующие файлы c указанным расширением после звездочки
+ `*.tfstate`
+ `*.tfvars`

#### 3. Любой файл с указаным окончанием после * будет игнорироваться
+ `*_override.tf`
+ `*_override.tf.json`

#### 4. Во всех папках, где существует каталог .terraform все файлы игнорируются
+ `**/.terraform/*`

#### 5. Все файлы с где встречается комбинация tfstate (Например temp.tfstate.json)
+ `*.tfstate.*`

>>Author: Sergey Galtsev