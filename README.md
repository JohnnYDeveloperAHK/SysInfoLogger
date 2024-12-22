# SysInfoLogger![SysInfoLoggerThumbnail](https://github.com/user-attachments/assets/29beb009-2849-433e-a5cc-97148198af89)


SysInfoLogger is an open-source tool designed for use in a virtual machine (VM) environment to simulate the information that malicious software might extract from your system. This tool aims to educate users about the types of data that could be accessed by a computer virus, helping improve awareness and security practices.

---

## Features

- Detects and displays key system information, including:
  - Windows OS version
  - Mouse and input devices
  - Connected and previously connected devices
  - Computer name and username
  - Router's private IP address
  - Public IP address (geo-location inferred if available)
- Automatically downloads `curl` if not pre-installed (optional prerequisite).
- Compiled version available as `.exe` for users without AutoHotkey v1 installed.
- Completely transparent and open-source for educational and testing purposes.

---

## Prerequisites

- **curl**: Required for retrieving the public IP address and other web-based data. The program will prompt to download it if absent.

---

## Installation

1. Clone this repository or download the script manually:
   ```
   git clone https://github.com/YourUsername/SysInfoLogger.git
   ```

2. Ensure AutoHotkey v1 is installed, or use the compiled `.exe` version.

3. Extract the `.exe` or `.ahk` file anywhere on your desktop or in a folder.

4. Run the file in a secure environment (preferably a virtual machine).

---

## Output

Shortly after running, the program will display detailed system information in a format similar to the image below, which shows an example output with sensitive information blanked out:

![SysInfoLoggerThumbnail](https://github.com/user-attachments/assets/29beb009-2849-433e-a5cc-97148198af89)

---

## Warning

### Sensitive Information Disclosure

- **Streamers**: Do NOT display the program window or output while live streaming (e.g., via OBS). The script reveals sensitive system details such as your public IP, username, and device information.
- **VPN Users**: Ensure your VPN is active before running this tool to avoid exposing your real public IP address.

### Intended Use Only

This program is strictly for educational purposes and VM testing. It is NOT intended for malicious activities.

---

## Disclaimer

I, **Nikola Glavinić**, am not responsible for any misuse of this tool. Its sole purpose is for testing and educational purposes.

---

## Usage

1. Extract the `.exe` or `.ahk` file to a folder or your desktop.
2. Run the script in a secure environment (preferably a virtual machine).
3. The tool will display detailed system information, simulating what could be accessed by a potential virus.

---

## Contributing

Contributions are welcome! If you have ideas or improvements, feel free to create a pull request or open an issue.

---

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

---

## License Summary

- You are free to use, modify, and distribute this software.
- You must provide attribution to the original author.
- Any modifications must be clearly stated.
