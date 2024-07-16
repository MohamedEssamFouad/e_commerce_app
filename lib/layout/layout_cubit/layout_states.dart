abstract class LayoutStates{

}

class LayoutIntialState extends LayoutStates{}


class LayoutLoadingState extends LayoutStates{}

class LayoutSucessState extends LayoutStates{}

class LayoutFailedState extends LayoutStates{
  String message;
  LayoutFailedState({required this.message});
}

class LayoutChangeBottom extends LayoutStates{}

class BannerSuccess extends LayoutStates{}
class BannerLoading extends LayoutStates{}
class BannerFailed extends LayoutStates{

}

class CatSuccess extends LayoutStates{}
class CatFailed extends LayoutStates{}


class ProductSuccess extends LayoutStates{}
class ProductFailed extends LayoutStates{}
class FilteredProductSuccess extends LayoutStates{}

class GetFavSucced extends LayoutStates{}
class GetFavFailed extends LayoutStates{}


class AddOrRemoveItemFromFavoritesSuccessState extends LayoutStates{}
class FailedToAddOrRemoveItemFromFavoritesState extends LayoutStates{}

class SuccessGetCart extends LayoutStates{}
class FailedGetCart extends LayoutStates{}

class SuccessAddToCard extends LayoutStates{}

class FFailedAddToCard extends LayoutStates{}