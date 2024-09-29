https://medium.com/@pipulpant/handling-custom-errors-in-cypress-f1daf1931b64



To kill processes that were started in a session using setsid, you can follow these steps:

1. Start a Process with setsid
First, if you want to start a process in its own session, you can use:

bash
Copy code
setsid your_command_here
2. Find the Session ID (SID)
After starting the process with setsid, you can find the session ID using:

bash
Copy code
ps -o sid,pid,cmd | grep your_command_here
This command will list the session IDs along with their associated process IDs. Look for the SID corresponding to your command.

3. Kill the Entire Session
To kill all processes in a specific session, you can use:

bash
Copy code
kill -TERM -<SID>
or, if you want to forcefully kill the processes:

bash
Copy code
kill -9 -<SID>
Example
If your process's SID is 12345, you would run:

bash
Copy code
kill -TERM -12345
Verify if the Processes Were Killed
You can verify if the processes were terminated using the same methods:

Using pgrep:

bash
Copy code
pgrep -s 12345
Using ps:

bash
Copy code
ps -o sid,pid,cmd | grep your_command_here
If there are no results, it means all processes in that session were successfully terminated.

Important Note
The negative sign before the SID indicates that you want to send the signal to all processes in that session.
Ensure you have the necessary permissions to kill these processes.



----------------


DevTools listening on ws://127.0.0.1:41611/devtools/browser/b9bda263-665f-4d50-935b-6f8950e863a8
libva error: vaGetDriverNameByIndex() failed with unknown libva error, driver_name = (null)

Ensure you have the necessary VA-API drivers installed. For example, on Ubuntu, you can run:

bash
Copy code
sudo apt install vainfo
For Intel:

bash
Copy code
sudo apt install intel-media-va-driver
For AMD:

bash
Copy code
sudo apt install mesa-va-drivers


----------------

Debugging:

https://stackoverflow.com/questions/52502130/debugging-cypress-tests-in-visual-studio-code
