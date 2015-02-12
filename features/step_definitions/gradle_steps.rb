Then(/^the Gradle test report should show some passing tests$/) do
  filename = __dir__+("/../../example/android/android-studio-robolectric-example/app/build/test-report/index.html")
  report = File.read(filename)

  num_tests = report.match(/<div class="infoBox" id="tests">\n<div class="counter">(\d+)<\/div>/)[1].to_i
  assert(num_tests > 0, "No tests found in report")
  assert(report.include?("100%"), "Reported success rate was not 100%")
end
