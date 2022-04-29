import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class Blockchain extends StatefulWidget {
  Blockchain({Key? key}) : super(key: key);

  @override
  State<Blockchain> createState() => _BlockchainState();
}

class _BlockchainState extends State<Blockchain> {
  final contractName = dotenv.env['CONTRACT_NAME'];
  final contractAddress = dotenv.env['CONTRACT_Address'];
  http.Client httpConnection = http.Client();
  late Web3Client polygonConnection;
  Uint8List? mintedImage;

  int index = 3; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) Navigator.pushNamed(context, 'walletMain_screen');
    if (index == 1) Navigator.pushNamed(context, 'searchMain_screen');
    if (index == 2) Navigator.pushNamed(context, 'transferMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
  }

  @override
  void initState() {
    final alchemyKey = dotenv.env['ALCHEMY_KEY_TEST'];
    super.initState();
    httpConnection = http.Client();
    polygonConnection = Web3Client(alchemyKey!, httpConnection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/bandedLogo.png', scale: 15),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF6634B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text('Show Image'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'nftImage_screen');
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF6634B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text('Mint NFT'),
                    onPressed: () async {
                      debugPrint("making NFT1");
                      mintedImage = await mintNFT();
                      debugPrint("making NFT2");
                      setState(() {
                        mintedImage = mintedImage;
                      });
                    }),
                showMintedImage()
              ])),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tickets),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.arrow_right_arrow_left),
              label: 'Transfer',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
          currentIndex: index,
          selectedItemColor: Color(0xFF6634B0),
          onTap: (index) {
            _onItemTapped(index, context);
          }),
    );
  }

  Future<DeployedContract> getContract() async {
    final name = dotenv.env['CONTRACT_NAME'];
    final address = dotenv.env['CONTRACT_ADDRESS'];
    String abi = await rootBundle.loadString("assets/abi.json");
    DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(abi, name!),
      EthereumAddress.fromHex(address!),
    );
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    DeployedContract contract = await getContract();
    ContractFunction function = contract.function(functionName);
    List<dynamic> result = await polygonConnection.call(
        contract: contract, function: function, params: args);
    return result;
  }

  Future<dynamic> mintNFT() async {
    final walletPrivateKey = dotenv.env['WALLET_PRIVATE_KEY'];
    final jsonCID = dotenv.env['JSON_CID'];
    EthPrivateKey credentials = EthPrivateKey.fromHex(walletPrivateKey!);
    DeployedContract contract = await getContract();
    ContractFunction function = contract.function('mint');
    String part1 = r'ipfs://';
    String part2 = r'/Star 1.json';
    String pictureURL = ("$part1$jsonCID$part2");
    var results = await Future.wait([
      getImageFromJson(),
      polygonConnection.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: function, parameters: [pictureURL]),
        fetchChainIdFromNetworkId: true,
        chainId: null,
      ),
      Future.delayed(const Duration(seconds: 2))
    ]);
    return results[0];
  }

  Future<Uint8List> getImageFromJson() async {
    final jsonCID = dotenv.env['JSON_CID'];
    final imagesCID = dotenv.env['IMAGES_CID'];
    String part1 = r'https://ipfs.io/ipfs/';
    String part2 = r'/Star 1.png';
    String url = ("$part1$imagesCID$part2");
    var resp = await httpConnection.get(Uri.parse(url));
    return Uint8List.fromList(resp.body.codeUnits);
  }

  Widget showMintedImage() {
    if (mintedImage == null) {
      debugPrint("null picture");
      return Container();
    } else {
      debugPrint("showing nft picture");
      return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text('now showing NFT:'),
        Image.memory(mintedImage!, width: 200, height: 300),
      ]);
    }
  }
}
