import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'QR Code Contact',
			home: QrCodeContactPage(),
			theme: ThemeData(
				brightness: Brightness.light,
				/* light theme settings */
			),
			darkTheme: ThemeData(
				brightness: Brightness.dark,
				/* dark theme settings */
			),
			themeMode: ThemeMode.system,
			/* ThemeMode.system to follow system theme, 
				 ThemeMode.light for light theme, 
				 ThemeMode.dark for dark theme
			*/
		);
	}
}

class QrCodeContactPage extends StatefulWidget {
	@override
	_QrCodeContactPageState createState() => _QrCodeContactPageState();
}

class _QrCodeContactPageState extends State<QrCodeContactPage> {
	final _formKey = GlobalKey<FormState>();
	String _name = "";
	String _phone = "";
	String _location = "";
	String _description = "";
	String _email = "";
	String _url = "";

	saveState() {
		setState(() {});
	}

	String mecardName() {
		if (_name.contains(",")) {
			return _name;
		}
		if (!_name.contains(" ")) {
			return _name;
		}
		int nameParts = _name.indexOf(" ");
		return "${_name.substring(nameParts + 1)},${_name.substring(0, nameParts)}";
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Create Contact QR Code'),
			),
			body: Form(
				key: _formKey,
				child: Padding(
					padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							Expanded(
								child: Align(
									widthFactor: 1,
									heightFactor: 1,
									child: QrImage(
										padding: const EdgeInsets.all(4.0),
										data:
												"MECARD:N:${mecardName()};TEL:${_phone.replaceAll("-", "")};EMAIL:$_email;ADR:$_location;URL:$_url;NOTE:$_description;;",
										version: QrVersions.auto,
										backgroundColor: Colors.white,
									),
								),
							),
							Padding(
								padding: const EdgeInsets.all(12.0),
								child: Card(
									shape: const RoundedRectangleBorder(
											borderRadius: BorderRadius.all(Radius.circular(10.0))),
									child: Padding(
										padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
										child: Column(
											children: [
												TextFormField(
													decoration: const InputDecoration(
														labelText: 'Name',
														suffixIcon: Icon(Icons.person),
														labelStyle: TextStyle(fontSize: 20),
													),
													onChanged: (value) => {_name = value, saveState()},
												),
												TextFormField(
													decoration: const InputDecoration(
															labelText: 'Phone',
															isDense: true,
															suffixIcon: Icon(Icons.phone)),
													onChanged: (value) => {_phone = value, saveState()},
												),
												TextFormField(
													decoration: const InputDecoration(
															labelText: 'Email',
															isDense: true,
															suffixIcon: Icon(Icons.email)),
													onChanged: (value) => {_email = value, saveState()},
												),
												TextFormField(
													decoration: const InputDecoration(
															labelText: 'Location',
															isDense: true,
															suffixIcon: Icon(Icons.location_pin)),
													onChanged: (value) =>
															{_location = value, saveState()},
												),
												TextFormField(
													decoration: const InputDecoration(
															labelText: 'Description',
															isDense: true,
															suffixIcon: Icon(Icons.note)),
													onChanged: (value) =>
															{_description = value, saveState()},
												),
												TextFormField(
													decoration: const InputDecoration(
															labelText: 'Website',
															isDense: true,
															suffixIcon: Icon(Icons.web)),
													onChanged: (value) => {_url = value, saveState()},
												),
											],
										),
									),
								),
							),
						],
					),
				),
			),
		);
	}
}
