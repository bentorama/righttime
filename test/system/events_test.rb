require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "accessing index page" do
    visit events_url
    assert_selector "h2"
    assert_selector "p"
  end
end
