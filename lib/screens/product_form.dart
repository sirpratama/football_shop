import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Form fields
  String _name = '';
  double _price = 0.0;
  String _description = '';
  String _thumbnail = '';
  String _category = '';
  bool _isFeatured = false;

  // Category options
  final List<String> _categories = [
    'Jerseys',
    'Boots',
    'Balls',
    'Training Equipment',
    'Accessories',
    'Collectibles',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  hintText: 'Enter product name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.shopping_bag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Product name cannot be empty';
                  }
                  if (value.length < 3) {
                    return 'Product name must be at least 3 characters';
                  }
                  if (value.length > 100) {
                    return 'Product name must not exceed 100 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 16.0),

              // Price Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter product price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                  suffixText: 'USD',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price cannot be empty';
                  }
                  final price = double.tryParse(value);
                  if (price == null) {
                    return 'Please enter a valid number';
                  }
                  if (price < 0) {
                    return 'Price cannot be negative';
                  }
                  if (price == 0) {
                    return 'Price must be greater than 0';
                  }
                  if (price > 1000000) {
                    return 'Price seems unrealistic (max: 1,000,000)';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),

              // Description Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter product description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description cannot be empty';
                  }
                  if (value.length < 10) {
                    return 'Description must be at least 10 characters';
                  }
                  if (value.length > 500) {
                    return 'Description must not exceed 500 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 16.0),

              // Thumbnail URL Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Thumbnail URL',
                  hintText: 'Enter image URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.image),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Thumbnail URL cannot be empty';
                  }
                  // Basic URL validation
                  final urlPattern = RegExp(
                    r'^https?:\/\/.+',
                    caseSensitive: false,
                  );
                  if (!urlPattern.hasMatch(value)) {
                    return 'Please enter a valid URL (starting with http:// or https://)';
                  }
                  return null;
                },
                onSaved: (value) {
                  _thumbnail = value!;
                },
              ),
              const SizedBox(height: 16.0),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.category),
                ),
                hint: const Text('Select a category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  setState(() {
                    _category = value ?? '';
                  });
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              const SizedBox(height: 16.0),

              // Featured Checkbox
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: CheckboxListTile(
                  title: const Text('Featured Product'),
                  subtitle: const Text('Display this product prominently'),
                  value: _isFeatured,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFeatured = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              const SizedBox(height: 24.0),

              // Save Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: const Icon(Icons.save),
                label: const Text(
                  'Save Product',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                    final request = context.read<CookieRequest>();
                    
                    // Debug: Check if user is logged in
                    print('Logged in: ${request.loggedIn}');
                    
                    // Check if logged in before sending
                    if (!request.loggedIn) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please login first to create products'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    
                    try {
                      // Get user_id (workaround for cookie issues on Flutter Web)
                      final userId = request.jsonData['user_id'];
                      
                      // Send product data to Django
                      final response = await request.post(
                        'http://localhost:8000/api/create/',
                        {
                          'name': _name,
                          'price': _price.toString(),
                          'description': _description,
                          'thumbnail': _thumbnail,
                          'category': _category,
                          'is_featured': _isFeatured.toString(),
                          'user_id': userId.toString(),  // Send user_id as workaround
                        },
                      );
                      
                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          // Show success dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Success!'),
                                content: Text(response['message'] ?? 'Product saved successfully!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close dialog
                                      Navigator.pop(context); // Return to previous page
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Show error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${response['message'] ?? 'Failed to save product'}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

