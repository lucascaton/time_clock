# Time Clock

Time Clock is a simple system that allows an user to register their punch ins and punch outs of the work environment in order to manage their hours worked.

# How to setup

1. Copy the project and install its dependencies:

    <code>git clone git@github.com:lucascaton/time_clock.git ~/time_clock</code>

    <code>cd ~/time_clock</code>

    <code>bundle install</code>

2. Copy and edit the database configs:

    <code>cp config/database.yml.example config/database.yml</code>

3. Copy and edit the application configs (You must choose an username and password that will access the application):

    <code>cp config/application.yml.example config/application.yml</code>

4. Run <code>rake db:setup</code> in order to setup database;

5. Start the aplication: <code>rails server</code> and done! You're ready to access the application:

    <pre>http://localhost:3000</pre>

# Screenshots

![Screenshot browser](https://raw.github.com/lucascaton/time_clock/master/screenshots/screenshot_browser.png)

![Screenshot iPhone](https://raw.github.com/lucascaton/time_clock/master/screenshots/screenshot_iphone.png)

## Licence

Copyright (c) 2013 Lucas Caton

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
