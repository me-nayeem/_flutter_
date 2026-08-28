## 3. JSON

**JSON (JavaScript Object Notation)** is a lightweight format used to **exchange data between Flutter apps and APIs**.

### 1. JSON Structure

JSON stores data using **key-value pairs**:

```json
{
  "name": "Nayeem",
  "age": 22
}
```

### 2. Objects

An object is surrounded by `{}` and contains key-value pairs:

```json
{
  "name": "Nayeem",
  "age": 22
}
```

### 3. Arrays

An array is a list surrounded by `[]`:

```json
{
  "subjects": ["Dart", "Flutter", "C++"]
}
```

### 4. Nested JSON

Objects/arrays can exist inside other objects:

```json
{
  "user": {
    "name": "Nayeem",
    "skills": ["Dart", "Flutter"]
  }
}
```

### 5. Parsing JSON

**Parsing = converting JSON data into Dart objects/data.**

```text
JSON → Dart
```

For example, API response → `User` model.

### 6. Encoding JSON

**Encoding = converting Dart data into JSON.**

```text
Dart → JSON
```

Usually used when sending data to an API.

### Remember

> **Parsing:** JSON → Dart
> **Encoding:** Dart → JSON
> **Object:** `{}`
> **Array:** `[]`
