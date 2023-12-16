# Download dependencies 
flutter pub get 
# Run tests with User feedback (in case some test are failing)
flutter test
# Run tests without user feedback regeneration tests.output and coverage/lcov.info
flutter test --machine --coverage > tests.output 

# Run the analysis and publish to the SonarQube server
D:\Workspace\MathGameKids\docker-repositories\Sonar-Docker\sonar-scanner-5.0.1.3006-windows\bin\sonar-scanner