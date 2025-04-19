# ImageViewerApp

A modern iOS application that lets users browse, favorite, and download images using the Unsplash API. Built with SwiftUI, MVVM architecture, and best iOS development practices.

---

### **Features**

- Fetch and display images from Unsplash in a grid view (Home Screen).
- View full image details, including photographer info, on tapping an image.
- Download images to device (with runtime permissions).
- Favorite images and store them locally using Realm database.
- View and manage favorited images in a dedicated Favorites tab.
- Remove images from favorites.

**Bonus Features (Optional):**

- Search images by keyword (or tag).
- Dark mode toggle.
- Swipe to delete in Favorites.
- Shimmer effect for image loading.

---

### **Screens**

1. **Home Screen (Image Grid View)**
   - Displays images from Unsplash in a lazy grid.
   - Shows photographer’s name below each image.
   - Tap an image to open Detail Screen.

2. **Detail Screen**
   - Full-screen image view.
   - Shows photographer’s name, username, and profile picture.
   - Actions: Download image (with permissions), Favorite/unfavorite image.

3. **Favorites Screen**
   - Accessed via bottom navigation tab.
   - Shows grid of favorited images.
   - Tap to view details, remove from favorites.
  
4. **Settings Screen**
   - Toggle app mode (Light mode & Dark mode)
   - About Info.

---

### **Architecture & Tech Stack**

- **Language:** Swift
- **UI:** SwiftUI
- **Architecture:** MVVM (Model-View-ViewModel)
- **Dependency Injection:** For unit testability
- **Database:** Realm (for favorites)
- **Async Handling:** Combine and Latest Concurrency
- **Permissions:** Handles runtime permissions for downloads

---

### **Setup Instructions**

1. **Clone the repository**
   ```bash
   git clone https://github.com/ham118/ImageViewerApp.git
   ```

2. **Install dependencies**
   - Open the project in Xcode.
   - No need to install any library as added manually so, when required to update then install Realm via Swift Package Manager and remove manually added ones.

3. **Unsplash API Key Configuration**
   - Register for a developer account at Unsplash.
   - Get your Access Key.
   - Add your API key to the project's APIConfig file (later hide it in a `Secrets.plist` or `keychain` as per project further instructions).

4. **Build and Run**
   - Open the `.xcodeproj` or `.xcworkspace` file in Xcode.
   - Build and run on a simulator or device.

---

### **Demo Video**

- [Watch Demo Video](https://drive.google.com/file/d/14qpitM01fb6qUHGJwqFv8dNgFNvPRgf8/view?usp=sharing)

---

### **Contributing**

- Fork the repository and create your branch.
- Submit a pull request with a clear description of your changes.

---

### **License**

- Note: This license has also been called the “New BSD License” or “Modified BSD License”. See also the 2-clause BSD License.

Copyright <Harsh M> <2025>

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

---

### **Contact**

- For any queries or issues, please open an issue in this repository.

---

> **Note:** This app is for educational and demonstration purposes, using the Unsplash API under their guidelines and terms of use.

---
