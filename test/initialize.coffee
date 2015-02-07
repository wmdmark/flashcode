tests = [
  './app-test'
  #'./sandbox/sandbox-tests'
  './auth/auth-tests'
  './card/card-tests'
  './card/create/create-card-tests'
]

for test in tests
  require test
