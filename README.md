### Functionality  
"Sike Hoe" is a malware that redirects the target to chrome tabs every minute  
If the target deletes the malware file spawning the chrome tabs, "Sike Hoe" will simply reproduce the malware file

---

### How it works
1. The `Win32Installer.bat` creates a directory called `System` in the user profile
2. The program then creates a `Win32Handler.bat` and a `Win32Helper.bat` in the directory
   - `Win32Helper.bat` is responsible for spawning the chrome tabs
   - `Win32Handler.bat` reproduces and schedules `Win32Helper.bat`
3. The program then schedules a task called "HostDriverSH" that runs the `Win32Handler.bat` file every minute
4. If the `Win32Handler.bat` program detects that the `Win32Helper.bat` is not registered in Task Scheduler, it...
   - creates a directory called `Applications` in the user profile
   - copies the `Win32Helper.bat` file over to the directory
   - registers the `Win32Helper.bat` file in the TaskScheduler as "sike", which will run every minute
  
---

### Deletion
To stop the malware from running, open Task Scheduler and delete the "HostDriverSH" and "sike" tasks.

---

### Customisation
Comments in the source code will guide you on how to customise the virus to your liking
