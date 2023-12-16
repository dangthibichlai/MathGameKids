@echo off

call flutter pub get
call flutter test
call flutter test --machine --coverage > tests.output

call docker-repositories\Sonar-Docker\sonar-scanner-5.0.1.3006-windows\bin\sonar-scanner
