import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({Key? key}) : super(key: key);

  final ArcticleController arcticleController = Get.put(ArcticleController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: appBar("مقالات جدید"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: arcticleController.articleList.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height / 6,
                          width: Get.width / 3,
                          child: CachedNetworkImage(
                            imageUrl:
                                arcticleController.articleList[index].image!,
                            imageBuilder: (((context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            })),
                            placeholder: (((context, url) {
                              return const Loading();
                            })),
                            errorWidget: ((context, url, error) {
                              return const Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: Colors.grey,
                              );
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width / 2,
                              child: Text(
                                arcticleController.articleList[index].title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  arcticleController.articleList[index].author!,
                                  style: textTheme.caption,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  arcticleController.articleList[index].view! +
                                      " بازدید ",
                                  style: textTheme.caption,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
