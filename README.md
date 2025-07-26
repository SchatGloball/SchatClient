# schat

schat

Client schat

A free messenger client schat that you can use on any device

Клиент свободного месседжера schat, который вы можете запустить на любом устройстве


## Getting Started

//Генерация grpc файлов клиента

dart pub global activate protoc_plugin
export PATH="$PATH":"$HOME/.pub-cache/bin"

protoc --dart_out=grpc:. -Iprotos protos/*.proto

protoc --dart_out=grpc:./generated  -Iprotos protos/social.proto
protoc --dart_out=grpc:./generated -Iprotos protos/chats.proto
protoc --dart_out=grpc:./generated -Iprotos protos/auth.proto
protoc --dart_out=grpc:./generated -Iprotos protos/call.proto 


flutter pub get
flutter build web
flutter build apk
flutter build linux
flutter build windows