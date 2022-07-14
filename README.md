# GOLANG-UNLEASH-GITLAB-EXAMPLE
## PROOF OF CONCEPT
Переосмысление кривых мануалов гитлаба ( https://docs.gitlab.com/15.1/ee/operations/feature_flags.html ).

## Подготовка запуска
* Перед запуском создать именованные вольюмы:
```
docker volume create gitlabdata
docker volume create gitlabdata2
docker volume create gitlabdata3
```
* Прописать в hosts 127.0.0.1 **myserver.ru**
* Возможно, потребуется перез запуском выкачать 
```
docker pull golang:1.18.3-alpine3.16
```
* После первоначальной сборки образа с go и запуска композа, остановить композ командой 
```
docker-compose down
```
* Запускалось на 10й винде
## Проверка
* После запуска композа и локального гитлаба, руками через браузер создать репу, а в ней содать Feature Flag **my_feature_name**
* Вытащить из вэб-интерфейса гитлаба Configure API_URL и InstanceID и отредактироавть **main.go** и **docker-compose.yaml**
* В меню Feature Flags Создать Strategies 50% , Environments: * и production
## Проверка курлом
```
curl -H "Content-Type: application/json" -H "Authorization: some-secret" -X GET localhost:81
```
## Результат проверки 
Ответы в консоли попеременно с localhost:81/1
* Feature enabled
* hello, world!
Ответы в консоли попеременно с localhost:81/2
* {"toggles":[]}
* {"toggles":[{"name":"my_feature_name","enabled":true,"variant":{"name":"disabled","enabled":false}}]}
