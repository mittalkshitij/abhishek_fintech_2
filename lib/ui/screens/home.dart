import 'package:abhishek_fintech/models/transactions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/home_future_provider.dart';
import '../../repos/hive_repo.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Properly dispose the scroll controller to avoid memory leaks
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final AsyncValue<List<Transactions>> transactionList =
        ref.watch(homeFutureProviderTransactionList);
    return Scaffold(
        backgroundColor: Colors.red,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //    leading: IconButton(
        //    onPressed: () {}, icon: const Icon(Icons.menu)),
        //   actions: [
        //     IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        //   ],
        // ),
        body: transactionList.when(data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('No Transactions available'));
          }
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.yellow, // AppBar background
                pinned: true,
                expandedHeight:
                    height * 0.54, // Adjust height as per your requirement
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment
                        .bottomLeft, // Align content to the bottom left
                    color: Colors
                        .black54, // Use a semi-transparent dark color for contrast
                    child: const Column(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Align content at the bottom
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Expense: ₹50,000', // Hardcoded value for total expense
                          style: TextStyle(
                            color: Colors
                                .white, // White text for better visibility
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Monthly Balance: ₹15,000', // Hardcoded value for monthly balance
                          style: TextStyle(
                            color: Colors
                                .white70, // Light white color for secondary text
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)) // White border
                            ),
                      ),
                      child: const Text(
                        'Play',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)), // White border
                          ),
                        ),
                        child: const Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CommonSliverBoxAdapter(
                movieData: data,
                title: 'Now Playing',
                ref: ref,
              ),
              transactionList.when(data: (popularData) {
                return CommonSliverBoxAdapter(
                  movieData: popularData,
                  title: 'Popular',
                  ref: ref,
                );
              }, error: (popularError, stkPopular) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(popularError.toString()),
                  ),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ],
          );
        }, error: (error, stk) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(error.toString()),
            ),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}

class CommonSliverBoxAdapter extends StatelessWidget {
  const CommonSliverBoxAdapter(
      {super.key,
      required this.movieData,
      required this.title,
      required this.ref});

  final List<Transactions> movieData;
  final String title;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10, bottom: 12.0, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'See all',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 190,
            width: 130, // Set height for the horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieData.length,
              itemBuilder: (context, index) {
                final posterPath = '';
                return posterPath != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, bottom: 0.5),
                        child: Container(
                          width: 130,
                          height: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border:
                                Border.all(color: Colors.white60, width: 0.3),
                            borderRadius: BorderRadius.circular(6.0),
                            image: const DecorationImage(
                              image: CachedNetworkImageProvider(
                                '',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          // child: CachedNetworkImage(
                          //     imageUrl:'${ImageEndPoint.imageBaseURL}${ImageEndPoint.fileSizeOriginal}$posterPath',
                          //     fit: BoxFit.cover,
                          //     placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                          //     errorWidget: (context, url, error) =>
                          //         const Icon(Icons.error),
                          //   ),
                          child: InkWell(
                            onTap: () {
                              // ref.read(hiveRepoProvider).addMovieToHive(movieData[index]);
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailScreen(movieData[index].id.toString(), movieData[index])));
                            },
                          ),
                        ),
                      )
                    : const Icon(Icons.error, color: Colors.white);
              },
            ),
          ),
        ],
      ),
    );
  }
}
