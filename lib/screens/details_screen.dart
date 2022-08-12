import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: CAMBIAR despues
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards(),
              
            ]

            )
            )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only( bottom: 10),
          color: Colors.black12,
          child: const Text('movie.title',
          style:  TextStyle(fontSize: 16),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin:  EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal:20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
              ),
          ),
          SizedBox(width: 20),

          Column(
            children: [
              Text('movi.tittle', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
              Text('movi.originalTittle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),

              Row(
                children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('movie.voteAvarenge', style: textTheme.caption)
                ],
              )

            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: 
      Text(
        'Est commodo consequat pariatur nisi. Amet sunt tempor sint mollit. Ipsum officia voluptate cupidatat velit elit exercitation nulla esse ex adipisicing et. Irure est ex mollit Lorem exercitation exercitation proident et incididunt laboris. Sit et minim laborum ipsum deserunt enim culpa sunt. Cupidatat eiusmod qui id exercitation in commodo enim consectetur cillum sit Lorem laborum laboris ullamco. Occaecat culpa occaecat mollit consectetur non ipsum.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
        ),
    );
  }
}