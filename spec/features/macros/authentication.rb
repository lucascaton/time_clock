# encoding: utf-8
module AcceptanceMacros
  def authenticate
    username, password = Settings.authentication.username, Settings.authentication.password

    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth(username, password)
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize(username, password)
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize(username, password)
    else
      raise "I don't know how to log in!"
    end
  end
end
