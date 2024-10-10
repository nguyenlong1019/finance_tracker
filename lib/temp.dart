ElevatedButton(
  onPressed: () async {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;

    CustomUser? user = await authService.signUp(email, password, name);
    if (user != null) {
      print('User registered: ${user.email}');
    }
  },
  child: Text('Đăng ký'),
),



ElevatedButton(
  onPressed: () async {
    String email = emailController.text;
    String password = passwordController.text;

    CustomUser? user = await authService.signIn(email, password);
    if (user != null) {
      print('User logged in: ${user.email}');
    }
  },
  child: Text('Đăng nhập'),
),


ElevatedButton(
  onPressed: () async {
    await authService.signOut();
    print('User signed out');
  },
  child: Text('Đăng xuất'),
),


ElevatedButton(
  onPressed: () async {
    Asset newAsset = Asset(
      assetId: 'asset1',
      name: 'Car',
      value: 10000.0,
    );
    await assetService.addAsset(authService.currentUser!.uid, newAsset);
    print('Asset added');
  },
  child: Text('Thêm tài sản'),
),



ElevatedButton(
  onPressed: () async {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;

    try {
      await authService.signUp(email, password, name);
      print('User registered successfully');
    } catch (e) {
      print(e.toString());
      // Hiển thị thông báo lỗi cho người dùng, ví dụ qua một dialog
    }
  },
  child: Text('Đăng ký'),
),
