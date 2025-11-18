# Assignment 7

## Widget Tree
- A Flutter UI is a tree of widgets. Each widget can have children, which can have their own children, and so on.
- Parents pass configuration down to children via constructor params and inherited data (e.g., theme, MediaQuery).
- Children report their size/layout needs up to parents; parents decide where/how to place them.
- Example: MaterialApp -> HomePage -> Scaffold -> Column -> [AppBar, Padding, ElevatedButton, ...].

## Widgets used in this project (from lib/main.dart)
1. MaterialApp: Top-level Material design app container; sets title, theme, routing, and home.
2. ThemeData: Holds app-wide colors, typography, etc. Provided to descendants via Theme.of(context).
3. HomePage (StatelessWidget): Your custom screen widget.
4. Scaffold: Provides page structure: app bar, body, floating buttons, snackbars, etc.
5. AppBar: The top application bar showing the page title.
6. Padding: Adds space around its child (EdgeInsets.all(16) here).
7. Column: Lays out children vertically.
8. ElevatedButton.icon: A button with an icon and text.
9. Icon: Shows a Material icon (e.g., Icons.list_alt).
10. Text: Renders text labels and content.
11. SizedBox: Adds fixed spacing (e.g., height: 12).
12. SnackBar: Temporary message bar for feedback.
13. ScaffoldMessenger: Shows SnackBar within the current Scaffold context.
14. MyHomePage (StatefulWidget) and its _MyHomePageState: Example counter screen (not used as home).
15. Center: Centers its child.
16. FloatingActionButton: Circular button floating above content.

## What does MaterialApp do, and why as root?
1. MaterialApp sets up Material design defaults (themes, fonts, localization), routing, navigation, and text direction.
2. It inserts inherited widgets that many descendants rely on (Theme, Navigator, MediaQuery).
3. Using it as the root ensures the whole app gets consistent Material behavior and can navigate between pages.

## StatelessWidget vs StatefulWidget
1. StatelessWidget: Immutable; renders purely from inputs. Use when UI doesn’t change over time (e.g., static pages, buttons with callbacks).
2. StatefulWidget: Holds mutable state inside a State object and can call setState to rebuild. Use for counters, form inputs, async data loading, animations.
3. HomePage is StatelessWidget (no internal state). MyHomePage is StatefulWidget (has _counter and setState).

## What is BuildContext and why is it important?
- BuildCOntext is a handle to a widgets location in the widget tree.
- It lets you:
    1. Access inherited data.
    2. Navigate or show UI elements tied to the current page.
    3. Build child widgets with proper theming and localization.
- In build(BuildContext context), i use context to fetch theme (Theme.of(context)) and to show snackbars via ScaffoldMessenger.of(context).

## Hot reload vs Hot restart
a. Hot Reload: Injects updated source code into the running Dart VM, preserves state, and rebuilds widgets. Fast, ideal for UI tweaks. Counter values, current screen, etc., remain.
b. Hot Restart: Fully restarts the app, clears state, re-runs main(). Slower, but ensures a clean state (useful when changes affect global state/initialization).

---

# Assignment 8

## Navigator.push() vs Navigator.pushReplacement()

### Navigator.push()
- **What it does**: Adds a new route on top of the navigation stack, keeping the previous route in memory.
- **Effect**: The user can press the back button to return to the previous screen.
- **Use case in Football Shop**: Used when navigating from `HomePage` to `ProductFormPage` (Add Product screen). The user should be able to return to the home page using the back button.

**Example from my application:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProductFormPage()),
);
```

### Navigator.pushReplacement()
- **What it does**: Replaces the current route with a new route, removing the previous route from the stack.
- **Effect**: The back button will not return to the replaced screen.
- **Use case in Football Shop**: Used in the drawer when navigating to `HomePage`. Since the drawer is accessible from multiple screens, we use `pushReplacement` to avoid stacking multiple home pages and to prevent circular navigation issues.

**Example from my application:**
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const HomePage()),
);
```

### Summary
- Use `push()` when the user should be able to go back (e.g., form submissions, detail views).
- Use `pushReplacement()` when you want to replace the current screen entirely (e.g., login to home, drawer navigation to avoid stack buildup).

---

## Widget Hierarchy: Scaffold, AppBar, and Drawer

### How I Use These Widgets

**1. Scaffold**
- The `Scaffold` widget provides the basic visual structure for Material Design pages.
- It's used as the root widget in both `HomePage` and `ProductFormPage`.
- Provides slots for: `appBar`, `drawer`, `body`, `floatingActionButton`, etc.

**2. AppBar**
- Displayed at the top of the screen within the `Scaffold`.
- Shows the page title and provides a consistent header across all pages.
- In my application, all AppBars have a consistent style with the primary color background and white text.

**3. Drawer**
- A sliding panel that appears from the left side of the screen.
- Implemented in `LeftDrawer` widget and reused across pages.
- Contains navigation options (Home, Add Product) for consistent navigation throughout the app.

### Structure in Football Shop
```
Scaffold (provides page structure)
├── AppBar (top bar with title)
├── Drawer (LeftDrawer - navigation menu)
└── Body (main content area)
    ├── HomePage: Column with buttons
    └── ProductFormPage: Form with input fields
```

### Benefits of This Hierarchy
1. **Consistency**: Every page follows the same structure (AppBar + Drawer + Body).
2. **Reusability**: The `LeftDrawer` widget is created once and reused across all pages.
3. **Material Design**: Following Material Design guidelines ensures a familiar, intuitive UI.
4. **Maintainability**: If I need to update navigation, I only edit `LeftDrawer` in one place.

---

## Layout Widgets: Padding, SingleChildScrollView, and ListView

### Why These Widgets Are Important

**1. Padding**
- **Purpose**: Adds space around widgets to prevent content from touching screen edges.
- **Usage in Football Shop**: Applied to the `HomePage` body to add 16px spacing on all sides.

```dart
Padding(
  padding: const EdgeInsets.all(16),
  child: Column(...),
)
```

**Advantage**: Improves visual appeal and readability by creating breathing room around UI elements.

**2. SingleChildScrollView**
- **Purpose**: Makes content scrollable when it exceeds the screen height.
- **Usage in Football Shop**: Wraps the form in `ProductFormPage` to ensure all form fields are accessible even on smaller screens.

```dart
SingleChildScrollView(
  padding: const EdgeInsets.all(16.0),
  child: Column(...), // Contains all form fields
)
```

**Advantages**:
- Prevents overflow errors when keyboard appears (which reduces available screen space).
- Ensures users can access all form fields regardless of screen size.
- Improves user experience on devices with various screen heights.

**3. ListView**
- **Purpose**: Efficiently displays scrollable lists of items.
- **Usage in Football Shop**: Used in the `LeftDrawer` for navigation menu items.

```dart
ListView(
  padding: EdgeInsets.zero,
  children: [
    DrawerHeader(...),
    ListTile(...), // Home
    ListTile(...), // Add Product
  ],
)
```

**Advantages**:
- Automatically handles scrolling when content exceeds available space.
- More efficient than `SingleChildScrollView` for lists (lazy loading).
- Built-in support for list items with consistent styling.

### Overall Benefits
These layout widgets ensure the application is **responsive**, **accessible**, and provides a **smooth user experience** across different device sizes and orientations.

---

## Color Theme and Visual Identity

### How I Set the Color Theme

I've configured a consistent color theme in `main.dart` using Flutter's `ThemeData`:

```dart
theme: ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.green,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
),
```

### Key Design Decisions

**1. Color Scheme**
- **Primary Color**: Green (from `colorSchemeSeed: Colors.green`)
  - Green represents football fields/pitches, creating a natural association with the sport.
  - Material 3 automatically generates a full color palette from the seed color.

**2. AppBar Styling**
- Consistent primary color background with white foreground text.
- Centered titles for better visual balance.
- Subtle elevation for depth.

**3. Button Styling**
- Custom colors for different actions:
  - **Blue (#80A1BA)**: "All Products" - informational
  - **Green (#41A67E)**: "My Products" - personal content
  - **Red (#842A3B)**: "Create Product" - action/call-to-action
- Rounded corners (8px border radius) for a modern, friendly look.
- Consistent padding for comfortable tap targets.

**4. Form Elements**
- Rounded input fields matching button styling.
- Icon prefixes for visual context.
- Clear validation messages in red.

### Visual Identity Benefits
1. **Brand Recognition**: Green = Football = Sports
2. **Consistency**: All pages use the same theme automatically via `Theme.of(context)`
3. **Accessibility**: Color contrasts meet WCAG guidelines
4. **Modern Look**: Material 3 design with smooth transitions
5. **Maintainability**: Changing theme colors in one place updates the entire app

The theme ensures that the Football Shop has a cohesive, professional appearance that reinforces its identity as a sports-focused e-commerce platform.

---

# Assignment 9

## Why We Need Dart Models for JSON Data

### The Problem with Direct Map<String, dynamic> Usage

When fetching or sending JSON data, we could directly use `Map<String, dynamic>`, but this approach has significant drawbacks:

**1. Type Validation Issues**
- **Without Models**: No compile-time type checking. You only discover type errors at runtime.
```dart
// Direct map usage - no type safety
Map<String, dynamic> data = json.decode(response);
String name = data['name']; // Might crash if 'name' is not a String
int price = data['price']; // Might crash if 'price' is not an int
```

- **With Models**: Strong type checking at compile time.
```dart
// Model usage - type safe
Product product = Product.fromJson(json.decode(response));
String name = product.fields.name; // Guaranteed to be String
int price = product.fields.price; // Guaranteed to be int
```

**2. Null Safety Problems**
- **Without Models**: Easy to access non-existent keys, leading to null pointer exceptions.
```dart
// Might be null, but no warning
String? category = data['category'];
// Might crash if the key doesn't exist
String description = data['description']; 
```

- **With Models**: Explicit null handling with Dart's null safety.
```dart
// Clear contract - must have these fields
class Fields {
  required String name;
  String? optionalField; // Explicitly nullable
}
```

**3. Maintainability Challenges**
- **Without Models**: 
  - Hard to track what fields exist in your data
  - Typos in key names cause runtime errors
  - Refactoring is error-prone
  - No IDE autocomplete support

- **With Models**: 
  - Clear data structure documentation
  - Compile-time error for typos
  - Safe refactoring with IDE support
  - Full autocomplete functionality

**4. Code Readability**
- **Without Models**: `data['fields']['user']['name']` - unclear structure
- **With Models**: `product.fields.user.name` - self-documenting code

### Consequences of Not Using Models

1. **Runtime Crashes**: Type mismatches and null access only discovered when running the app
2. **Debugging Nightmares**: Hard to trace where data corruption occurs
3. **Team Collaboration Issues**: No clear API contract between team members
4. **Refactoring Risks**: Changing field names requires searching through strings
5. **No IntelliSense**: IDE can't help with field names and types

**Conclusion**: Models provide type safety, null safety, and maintainability - essential for robust Flutter applications.

---

## HTTP Package vs CookieRequest Package

### HTTP Package (`http`)
**Purpose**: Provides basic HTTP client functionality for making requests to web servers.

**Capabilities**:
- Send GET, POST, PUT, DELETE requests
- Handle request headers and body
- Receive and parse responses
- Basic HTTP status code handling

**Limitations**:
- No automatic cookie management
- No session persistence
- No built-in authentication handling

**Example Usage**:
```dart
import 'package:http/http.dart' as http;

final response = await http.get(Uri.parse('https://api.example.com/data'));
// Need to manually handle cookies and authentication
```

### CookieRequest Package (`pbp_django_auth`)
**Purpose**: Specialized HTTP client designed for Django integration with automatic session management.

**Capabilities**:
- Everything `http` does, PLUS:
- **Automatic cookie management**: Stores and sends cookies automatically
- **Session persistence**: Maintains login state across requests
- **Django CSRF token handling**: Automatically includes CSRF tokens
- **Simplified authentication**: Built-in login/logout methods
- **Shared state**: One instance can be used throughout the app

**Example Usage**:
```dart
final request = context.read<CookieRequest>();

// Login - automatically stores session cookies
await request.login("http://localhost:8000/auth/login/", {
  'username': username,
  'password': password,
});

// Future requests automatically include authentication
final data = await request.get('http://localhost:8000/api/products/');
// No need to manually add authentication headers!
```

### Key Differences

| Feature | HTTP Package | CookieRequest Package |
|---------|-------------|----------------------|
| Basic HTTP requests | ✓ | ✓ |
| Cookie management | Manual | Automatic |
| Session persistence | Manual | Automatic |
| Django CSRF support | Manual | Automatic |
| Authentication state | Manual tracking | Built-in |
| Use case | General HTTP | Django integration |

### Why We Use CookieRequest in This Assignment

1. **Seamless Django Integration**: Works perfectly with Django's session-based authentication
2. **Automatic Cookie Handling**: No need to manually extract and attach session cookies
3. **Persistent Login State**: User stays logged in across app navigation
4. **CSRF Protection**: Automatically handles Django's CSRF token requirements
5. **Simpler Code**: Reduces boilerplate for authenticated requests

---

## Why CookieRequest Needs to Be Shared

### The Problem with Multiple Instances

If each component creates its own `CookieRequest` instance:
```dart
// WRONG - each screen creates its own instance
class LoginPage extends StatelessWidget {
  final request = CookieRequest(); // Instance 1
}

class ProductListPage extends StatelessWidget {
  final request = CookieRequest(); // Instance 2 - no cookies!
}
```

**Issues**:
1. **Lost Authentication**: Login cookies stored in Instance 1 are not available in Instance 2
2. **No Session Continuity**: Each request appears to come from a different user
3. **Memory Waste**: Multiple unnecessary HTTP clients
4. **Inconsistent State**: Can't track if user is logged in across the app

### The Solution: Provider Pattern

We use Flutter's `Provider` to create a **single shared instance**:

```dart
// In main.dart
Provider(
  create: (_) {
    CookieRequest request = CookieRequest();
    return request;
  },
  child: MaterialApp(...),
)
```

**Benefits**:

1. **Single Source of Truth**: One instance holds all authentication state
2. **Session Persistence**: Cookies from login are available everywhere
3. **Consistent User State**: All components see the same login status
4. **Easy Access**: Any widget can access via `context.watch<CookieRequest>()`

### How It Works

```dart
// Login page stores cookies
final request = context.watch<CookieRequest>();
await request.login(...); // Cookies stored in THIS instance

// Product list page uses SAME instance
final request = context.watch<CookieRequest>();
await request.get(...); // Automatically includes cookies from login!

// Logout affects all components
await request.logout(); // Clears cookies in the shared instance
```

### Analogy
Think of `CookieRequest` like a **keycard** to access a building:
- **Without sharing**: Each room gives you a new keycard, but only the entrance card has access rights
- **With sharing**: You get one keycard at the entrance and use it for all rooms

**Conclusion**: Sharing `CookieRequest` via Provider ensures authentication state is consistent throughout the app, enabling seamless user experience.

---

## Flutter-Django Connectivity Configuration

### Required Configurations and Why They're Needed

#### 1. Adding 10.0.2.2 to Django's ALLOWED_HOSTS

**Configuration**:
```python
# settings.py
ALLOWED_HOSTS = ['localhost', '127.0.0.1', '10.0.2.2']
```

**Why**:
- `10.0.2.2` is the special IP address for the **Android emulator** to access the host machine's localhost
- Android emulator runs in a virtual environment separate from your computer
- `localhost` inside the emulator refers to the emulator itself, not your computer
- `10.0.2.2` routes traffic from emulator to your computer's `localhost:8000`

**What happens without it**:
```
Connection refused: Django rejects requests from 10.0.2.2
Error: "Invalid HTTP_HOST header: '10.0.2.2:8000'"
```

#### 2. Enabling CORS (Cross-Origin Resource Sharing)

**Configuration**:
```python
# settings.py
INSTALLED_APPS = [
    ...
    'corsheaders',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    ...
]

CORS_ALLOW_ALL_ORIGINS = True  # For development
CORS_ALLOW_CREDENTIALS = True
```

**Why**:
- Flutter app (running on emulator) is a different "origin" than Django server
- Browsers and mobile apps enforce CORS security policy
- Without CORS headers, Flutter's HTTP requests are blocked
- `CORS_ALLOW_CREDENTIALS = True` allows cookies to be sent cross-origin

**What happens without it**:
```
CORS policy error: "Access to XMLHttpRequest has been blocked"
Cookies not sent: Authentication fails even after login
```

#### 3. Configuring SameSite Cookie Settings

**Configuration**:
```python
# settings.py
SESSION_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SECURE = False  # True in production with HTTPS
CSRF_COOKIE_SAMESITE = 'None'
CSRF_COOKIE_SECURE = False
```

**Why**:
- `SameSite='Lax'` (default) blocks cookies in cross-origin requests
- Flutter app and Django server are technically cross-origin
- `SameSite='None'` allows cookies to be sent from Flutter to Django
- `Secure=False` allows cookies over HTTP (development only; use True with HTTPS in production)

**What happens without it**:
```
Session cookies not sent: User appears logged out on every request
CSRF token missing: POST requests rejected with CSRF verification error
```

#### 4. Android Internet Permission

**Configuration**:
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<manifest>
    <uses-permission android:name="android.permission.INTERNET" />
    ...
</manifest>
```

**Why**:
- Android's security model requires explicit permission for network access
- Without this permission, all network requests are silently blocked
- Required for any app that communicates with external servers

**What happens without it**:
```
All HTTP requests fail silently
SocketException: "Permission denied"
No connection to Django server possible
```

### Complete Flow

```
Flutter App (Emulator) → 10.0.2.2:8000 → Django Server
                    ↑                         ↓
        Internet Permission         ALLOWED_HOSTS check
                    ↑                         ↓
              CORS check                 Process request
                    ↑                         ↓
        SameSite cookie settings     Return response with cookies
                    ↑                         ↓
              Authentication           Store cookies for future
```

### Summary

| Configuration | Purpose | Without It |
|--------------|---------|-----------|
| `10.0.2.2` in ALLOWED_HOSTS | Route emulator to host | Connection refused |
| CORS enabled | Allow cross-origin requests | Requests blocked |
| SameSite='None' | Send cookies cross-origin | Auth state lost |
| Internet permission | Allow network access | All requests fail |

All four configurations are **essential** for Flutter-Django communication to work properly.

---

## Data Transmission Mechanism: Input to Display

### Step-by-Step Flow

#### 1. User Input in Flutter Form

```dart
// User fills out the form
TextField(
  controller: _nameController,
  decoration: InputDecoration(labelText: 'Product Name'),
)
```

**What happens**: User types data into form fields (name, price, description, etc.)

#### 2. Form Validation

```dart
if (_formKey.currentState!.validate()) {
  _formKey.currentState!.save();
  // Validation passed, proceed
}
```

**What happens**: 
- Flutter validates each field (not empty, correct type, etc.)
- If validation fails, error messages shown
- If validation passes, proceed to step 3

#### 3. Data Preparation

```dart
final request = context.read<CookieRequest>();
final response = await request.postJson(
  "http://10.0.2.2:8000/api/create-product/",
  jsonEncode({
    "name": _name,
    "price": _price,
    "description": _description,
    "thumbnail": _thumbnail,
    "category": _category,
    "is_featured": _isFeatured,
  }),
);
```

**What happens**: 
- Dart objects converted to JSON string
- Example: `{"name": "Football", "price": 50, ...}`
- HTTP headers added (Content-Type, cookies, CSRF token)

#### 4. Network Transmission

```
Flutter App → HTTP POST Request → Django Server
   (JSON)                           (Receives)
```

**What happens**:
- Request travels through Android emulator → 10.0.2.2 → localhost:8000
- Django receives JSON payload
- Authentication cookies verified

#### 5. Django Processing

```python
# views.py
@login_required
def create_product(request):
    data = json.loads(request.body)
    product = Product.objects.create(
        user=request.user,
        name=data['name'],
        price=data['price'],
        description=data['description'],
        # ...
    )
    return JsonResponse({'status': 'success', 'id': product.id})
```

**What happens**:
- JSON parsed into Python dictionary
- Data validated and saved to database
- Response JSON created

#### 6. Response Transmission

```
Django Server → HTTP Response → Flutter App
  (JSON)                          (Receives)
```

**What happens**:
- Response travels back to Flutter
- Contains status, message, possibly created object ID

#### 7. Display in Flutter

**Option A: Show in Dialog**
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Product Saved!'),
    content: Text('Name: $_name\nPrice: \$$_price'),
  ),
);
```

**Option B: Navigate to List and Display**
```dart
// Navigate to product list
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ProductListPage()),
);

// In ProductListPage:
Future<List<Product>> fetchProducts() async {
  final response = await request.get('http://10.0.2.2:8000/json/');
  List<Product> products = [];
  for (var data in response) {
    products.add(Product.fromJson(data));
  }
  return products;
}
```

**What happens**:
- New product appears in the list
- User sees their input displayed on screen

### Complete Example: Create Product Flow

```
1. User fills form → "Manchester United Jersey", "$89.99", "Official jersey"
2. Validation → All fields valid ✓
3. Convert to JSON → {"name": "Manchester United Jersey", "price": 89.99, ...}
4. HTTP POST → http://10.0.2.2:8000/api/create-product/
5. Django saves → Product(id=5, name="Manchester United Jersey", ...)
6. Response → {"status": "success", "id": 5}
7. Show dialog → "Product Saved Successfully! ID: 5"
8. Navigate to list → User sees new product in ProductListPage
9. Display → Card showing "Manchester United Jersey - $89.99"
```

### Data Format Transformations

```
User Input (UI) → Dart Variables → JSON String → HTTP Body
                                                     ↓
Display (UI) ← Dart Objects ← Parse JSON ← Database Record
```

---

## Authentication Mechanism: Login, Registration, and Logout

### 1. Registration Flow

#### Step 1: User Enters Data in Flutter
```dart
// register.dart
TextField(controller: _usernameController)
TextField(controller: _passwordController)
TextField(controller: _confirmPasswordController)
```

**User action**: Fill in username, password, confirm password

#### Step 2: Flutter Sends Registration Request
```dart
final response = await request.postJson(
  "http://10.0.2.2:8000/auth/register/",
  jsonEncode({
    "username": username,
    "password1": password1,
    "password2": password2,
  }),
);
```

**What's sent**:
```json
{
  "username": "john_doe",
  "password1": "securepass123",
  "password2": "securepass123"
}
```

#### Step 3: Django Processes Registration
```python
# Django authentication/views.py
@csrf_exempt
def register(request):
    data = json.loads(request.body)
    username = data['username']
    password1 = data['password1']
    password2 = data['password2']
    
    # Validate passwords match
    if password1 != password2:
        return JsonResponse({
            "status": False,
            "message": "Passwords don't match."
        })
    
    # Create user
    try:
        user = User.objects.create_user(
            username=username,
            password=password1
        )
        user.save()
        return JsonResponse({
            "username": user.username,
            "status": 'success',
            "message": "User created successfully!"
        })
    except IntegrityError:
        return JsonResponse({
            "status": False,
            "message": "Username already exists."
        })
```

#### Step 4: Flutter Handles Response
```dart
if (response['status'] == 'success') {
  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Successfully registered!')),
  );
  // Navigate to login page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
```

### 2. Login Flow

#### Step 1: User Enters Credentials
```dart
// login.dart
TextField(controller: _usernameController)
TextField(controller: _passwordController, obscureText: true)
```

#### Step 2: Flutter Sends Login Request
```dart
final response = await request.login(
  "http://10.0.2.2:8000/auth/login/",
  {
    'username': username,
    'password': password,
  }
);
```

**Special note**: Using `request.login()` instead of `postJson()` for automatic cookie handling

#### Step 3: Django Authenticates User
```python
# Django authentication/views.py
from django.contrib.auth import authenticate, login

@csrf_exempt
def login_view(request):
    username = request.POST['username']
    password = request.POST['password']
    
    # Verify credentials
    user = authenticate(username=username, password=password)
    
    if user is not None:
        if user.is_active:
            # Create session
            login(request, user)
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login successful!"
            })
        else:
            return JsonResponse({
                "status": False,
                "message": "Account disabled."
            })
    else:
        return JsonResponse({
            "status": False,
            "message": "Invalid credentials."
        })
```

**What Django does**:
1. Checks username and password against database
2. If valid, creates a session in the database
3. Returns session cookie in HTTP response headers

#### Step 4: CookieRequest Stores Session Cookie
```
Response Headers:
Set-Cookie: sessionid=abc123xyz789; Path=/; HttpOnly
```

**What happens**:
- `CookieRequest` automatically extracts and stores the cookie
- Future requests will include this cookie
- No manual cookie handling needed!

#### Step 5: Flutter Navigates to Home
```dart
if (request.loggedIn) {
  String message = response['message'];
  String uname = response['username'];
  
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("$message Welcome back, $uname.")),
  );
}
```

**User sees**: Home page with "Login successful! Welcome back, john_doe."

### 3. Authenticated Requests

After login, all requests include the session cookie automatically:

```dart
// This request automatically includes authentication
final response = await request.get('http://10.0.2.2:8000/json/');

// Django receives:
// Headers: Cookie: sessionid=abc123xyz789
// Django knows this is john_doe's request!
```

**Django side**:
```python
@login_required
def get_products(request):
    # request.user is automatically set to john_doe
    products = Product.objects.filter(user=request.user)
    return JsonResponse(list(products.values()), safe=False)
```

### 4. Logout Flow

#### Step 1: User Clicks Logout
```dart
// left_drawer.dart
ListTile(
  title: Text('Logout'),
  onTap: () async {
    final response = await request.logout(
      "http://10.0.2.2:8000/auth/logout/"
    );
    // Handle response
  },
)
```

#### Step 2: Django Destroys Session
```python
# Django authentication/views.py
from django.contrib.auth import logout

def logout_view(request):
    username = request.user.username
    logout(request)  # Destroys session
    return JsonResponse({
        "username": username,
        "status": True,
        "message": "Logged out successfully!"
    })
```

**What Django does**:
1. Deletes session from database
2. Invalidates session cookie
3. Returns response

#### Step 3: Flutter Clears Authentication State
```dart
if (response['status']) {
  String uname = response["username"];
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Goodbye, $uname.")),
  );
  
  // Navigate back to login
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
```

**User sees**: Redirected to login page with "Goodbye, john_doe."

### Authentication State Diagram

```
┌─────────────┐
│ Not Logged  │
│     In      │
└──────┬──────┘
       │ Register/Login
       ↓
┌─────────────┐
│  Logged In  │ ← Session cookie stored
│             │ ← All requests authenticated
└──────┬──────┘
       │ Logout
       ↓
┌─────────────┐
│ Not Logged  │
│     In      │
└─────────────┘
```

### Security Features

1. **Password Hashing**: Django stores hashed passwords, never plain text
2. **CSRF Protection**: Django validates CSRF tokens on state-changing requests
3. **Session Security**: Session IDs are cryptographically secure random strings
4. **HttpOnly Cookies**: Session cookies not accessible to JavaScript (XSS protection)
5. **Login Required**: `@login_required` decorator protects sensitive endpoints

---

## Implementation Checklist: Step-by-Step

### 1. Setup and Dependencies

**Added required packages** in `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.2.0
  provider: ^6.1.1
  pbp_django_auth: ^0.4.0
```

**Installed packages**:
```bash
flutter pub get
```

### 2. Created Dart Model (`lib/models/product.dart`)

- Analyzed Django Product model structure
- Generated `Product` class with `fromJson` and `toJson` methods
- Created nested `Fields` class for product attributes
- Ensured field names match Django model (e.g., `is_featured` → `isFeatured`)

**Key decisions**:
- Used `required` keyword for non-nullable fields
- Handled JSON serialization for nested structures
- Matched data types (int for price, bool for isFeatured)

### 3. Integrated Provider for CookieRequest (`lib/main.dart`)

**Updated `main.dart`**:
- Wrapped `MaterialApp` with `Provider`
- Created single `CookieRequest` instance
- Changed initial route to `LoginPage` instead of `HomePage`

**Why**: Ensures authentication state is shared across all screens

### 4. Created Authentication Pages

**a. Login Page (`lib/screens/login.dart`)**:
- Text fields for username and password
- Login button calling `request.login()`
- Navigation to `HomePage` on success
- Link to registration page
- Error dialog for failed login

**b. Registration Page (`lib/screens/register.dart`)**:
- Text fields for username, password, confirm password
- Register button calling `request.postJson()`
- Navigation to login page on success
- Error handling for duplicate usernames, password mismatches

**Design choices**:
- Used cards for visual appeal
- Added football icon for branding
- Consistent styling with app theme

### 5. Created Product List Page (`lib/screens/product_list.dart`)

**Features implemented**:
- `FutureBuilder` to fetch products from Django asynchronously
- `fetchProducts()` function using `request.get()`
- Product cards displaying thumbnail, name, price, category, description
- Featured badge for `isFeatured` products
- Tap navigation to detail page
- Filter button in AppBar (for future filtering by user)
- Loading indicator while fetching
- Empty state when no products found

**Design choices**:
- Card-based layout for each product
- Horizontal layout with thumbnail on left
- Truncated description (2 lines max)

### 6. Created Product Detail Page (`lib/screens/product_detail.dart`)

**Features implemented**:
- Full-size product image at top
- All product attributes displayed
- Featured badge
- Category badge
- Detailed information card
- Back button to return to list

**UI improvements**:
- Hero animation for image transition (set up for future enhancement)
- Organized layout with clear sections
- Readable typography with proper spacing

### 7. Updated Drawer (`lib/widgets/left_drawer.dart`)

**Added navigation options**:
- Home
- Product List (new)
- Add Product
- Logout (new)

**Logout implementation**:
- Calls `request.logout()`
- Shows goodbye message
- Navigates back to login page

**Design notes**:
- Used `Navigator.pushReplacement()` for Home to avoid stack buildup
- Used `Navigator.push()` for other pages to allow back navigation

### 8. Updated Product Form (`lib/screens/product_form.dart`)

**No changes needed** - form already implemented in Assignment 8, but can be extended to:
- Send data to Django API instead of just showing dialog
- Use `request.postJson()` for authenticated product creation

### 9. Configured Android Permissions

**Updated `android/app/src/main/AndroidManifest.xml`**:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

**Why**: Required for network requests on Android

### 10. Testing Strategy (for you to complete)

**What to test**:
1. Django backend is running and accessible
2. Django authentication endpoints exist (`/auth/login/`, `/auth/register/`, `/auth/logout/`)
3. Django JSON endpoint exists (`/json/`)
4. Django CORS and cookie settings configured
5. Flutter login works and stores cookies
6. Product list displays data from Django
7. Product detail shows all fields
8. Logout works and redirects to login

### 11. Documented Everything in README.md

- Comprehensive answers to all assignment questions
- Code examples and explanations
- Architecture decisions and rationale

### Key Implementation Principles

1. **Separation of Concerns**: Models, views, and widgets in separate files
2. **Reusability**: Drawer widget used across multiple pages
3. **Type Safety**: Strong typing with Dart models
4. **Error Handling**: Try-catch blocks and null checks
5. **User Feedback**: Loading indicators, snackbars, error dialogs
6. **Consistent Styling**: Theme applied throughout
7. **Navigation Flow**: Logical user journey from login → home → list → detail

### Next Steps for Production

1. Replace `http://10.0.2.2:8000` with your deployed Django URL
2. Implement user-specific filtering in product list
3. Connect product form to Django create endpoint
4. Add pull-to-refresh in product list
5. Implement proper error handling for network failures
6. Add loading states for all async operations
7. Implement proper logout confirmation dialog
8. Add image caching for better performance