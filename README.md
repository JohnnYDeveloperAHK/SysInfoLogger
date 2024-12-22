# SysInfoLogger![SysInfoLoggerThumbnail](https://github.com/user-attachments/assets/6de34950-0d2b-4cfe-afca-969ba8601afc)


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

2. Ensure AutoHotkey v1 is installed on your system.

3. Run the script (`SysInfoLogger.ahk`) in a virtual machine environment for best results.

---

## Warning

### Sensitive Information Disclosure

- **Streamers**: Do NOT display the program window or output while live streaming (e.g., via OBS). The script reveals sensitive system details such as your public IP, username, and device information.
- **VPN Users**: Ensure your VPN is active before running this tool to avoid exposing your real public IP address.

### Intended Use Only

This program is strictly for educational purposes and VM testing. It is NOT intended for malicious activities.

---

## Usage

1. Run the script in a secure environment (preferably a virtual machine).
2. The tool will display detailed system information, simulating what could be accessed by a potential virus.

---

## Contributing

Contributions are welcome! If you have ideas or improvements, feel free to create a pull request or open an issue.

---

## License

This project is licensed under the Apache License 2.0 License. See the [LICENSE](LICENSE) file for details.

---

## Disclaimer

SysInfoLogger is intended for **responsible use only**. JohnnYDeveloperAHK is not liable for any misuse of this tool.
