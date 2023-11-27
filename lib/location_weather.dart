import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/utils/test_style_theme.dart';

class LocationWeather extends StatefulWidget {
  const LocationWeather({super.key});

  @override
  State<LocationWeather> createState() => _LocationWeatherState();
}

class _LocationWeatherState extends State<LocationWeather> {
  Location location = Location();


  @override
  void initState() {
    initLocationPermission();
    super.initState();
  }
  initLocationPermission()async{
    if(await location.hasPermission() != PermissionStatus.granted){
       await location.requestPermission();
    }
    LocationData data = await location.getLocation();
    print('long: ${data.longitude}, lat: ${data.latitude}');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.overlay,
          image: DecorationImage(
              image: AssetImage(
                "assets/images/paris.png",
              ),
              fit: BoxFit.cover),
          gradient: LinearGradient(
              stops: [0.1, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(226, 0, 0, 0),
                Color.fromARGB(0, 0, 0, 0)
              ]),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              25,
              MediaQuery.of(context).padding.top + 25,
              24,
              MediaQuery.of(context).padding.bottom + 15),
          width: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0.1, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(120, 0, 0, 0),
                  Color.fromARGB(36, 0, 0, 0)
                ]),
          ),
          child: Column(
            children: [
              // main navigator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Paris",
                        style: TextStyleTheme.mediumTextStyle,
                      )
                    ],
                  ),
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              )
              ,const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text("June 19",style: TextStyleTheme.bigTextStyle.copyWith(fontSize:55),),
                    Text("Updated as of 6/7/2023 12:25 PM",style: TextStyleTheme.smallTextStyle,),
                    _buildWeatherStatus(statusImage:"assets/images/sun.png",status: "Clear",temp: "24"),
                    SizedBox(height: (MediaQuery.of(context).size.height*0.04).clamp(30, 75),),
                    _buildDetails(),
                    const SizedBox(height: 30,),
                    _buildForcast()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherStatus({required String statusImage,required String status,required String temp}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40,),
        Image.asset(statusImage,height: 80,width: 80,fit: BoxFit.cover,),
        Text(status,style: TextStyleTheme.bigTextStyle.copyWith(fontWeight: FontWeight.w700,fontSize: 50,shadows: [
          const Shadow(
            color: Colors.black,
            offset: Offset(0, 2),
            blurRadius: 5
          )
        ])),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 30,),
            Text(temp,style: TextStyleTheme.bigTextStyle.copyWith(fontWeight: FontWeight.w700,fontSize: 88,shadows: [
          const Shadow(
            color: Colors.black,
            offset: Offset(0, 2),
            blurRadius: 5
          )
        ])),
        Text("ºC",style: TextStyleTheme.bigTextStyle.copyWith(fontWeight: FontWeight.w700,fontSize: 30,shadows: [
          const Shadow(
            color: Colors.black,
            offset: Offset(0, 2),
            blurRadius: 5
          )
        ]))
          ],
        )
      
      ],
    );
  }

  Widget _buildDetails(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        detailsHolder(DetailsType.humidity, "56"),
        detailsHolder(DetailsType.wind, "4.63"),
        detailsHolder(DetailsType.temp, "22")
      ],
    );
  }

  Widget detailsHolder(DetailsType type,String value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          elevation: 15,
          shadowColor: const Color.fromARGB(181, 0, 0, 0),
          child: Image.asset(type == DetailsType.humidity?"assets/images/humidity.png":type == DetailsType.wind?"assets/images/wind.png":"assets/images/temp.png")),
        Text(type == DetailsType.humidity?"HUMIDITY":type == DetailsType.wind?"WIND":"FEELS LIKE",style: TextStyleTheme.bigTextStyle.copyWith(fontSize: 17),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(width: 30,),
            Text(value,style: TextStyleTheme.bigTextStyle.copyWith(fontSize: 17)),
        Text(type == DetailsType.humidity?"%":type == DetailsType.wind?"km/h":"º",style: TextStyleTheme.bigTextStyle.copyWith(fontSize: 16))
          ],
        ),
      
        // Text(value,style: TextStyleTheme.bigTextStyle.copyWith(fontSize: 17),)
      ],
    );
  }
}

Widget _buildForcast(){
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color.fromARGB(148, 83, 83, 83)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        forcastHolder("assets/images/rain_c.png","22","Wed 16","1-5"),
        forcastHolder("assets/images/rain_c.png","25","Wed 17","1-5"),
        forcastHolder("assets/images/rain_c.png","23","Wed 18","5-10"),
        forcastHolder("assets/images/rain_c.png","25","Wed 19","1-5"),
      ],
    ),
  );
}
Widget forcastHolder(String weatherIcon,String temp,String day,String windSpeed){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(day,style: TextStyleTheme.mediumTextStyle,),
      const SizedBox(height: 10,),
      Image.asset(weatherIcon,fit: BoxFit.cover,height: 60,width: 60,),
      const SizedBox(width: 6,),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 6,),
            Text(temp,style: TextStyleTheme.mediumTextStyle.copyWith(fontSize: 20)),
        Text("º",style: TextStyleTheme.mediumTextStyle)
          ],
        ),
        const SizedBox(height: 6,),
        Text("$windSpeed \n km/h",style: TextStyleTheme.mediumTextStyle.copyWith(fontSize: 14),textAlign: TextAlign.center,),
      
    ],
  );
}
enum DetailsType{
  humidity,
  temp,
  wind
}
