class AppState {
 

    int totalProduct;
    int totalOrder;
    int totalCategory;

    ////////////category
    List categoryList=[];
    bool categoryLoading= true;

    ////////////product
    List productList=[];
    bool productLoading= true;

    ////////////available product
    List availableProductList=[];
    bool availableProductLoading= true;

    ////////////emptyStock product
    List emptyStockProductList=[];
    bool emptyStockProductLoading= true;

    ////////////offer product
    List offerProductList=[];
    bool offerProductLoading= true;


    
    //////////// order
    List orderList=[];
    bool orderLoading= true;
 
  ////////////////  search List //////////
   List searchProductList=[];

  AppState(
      {
       this.totalProduct,
       this.totalOrder,
       this.categoryList, 
       this.categoryLoading,
       this.productList, 
       this.productLoading,
       this.totalCategory,
       this.availableProductList, 
       this.availableProductLoading,
       this.emptyStockProductList, 
       this.emptyStockProductLoading,
       this.offerProductList, 
       this.offerProductLoading,
       this.searchProductList,
       this.orderList,
       this.orderLoading
      });

  AppState copywith(
      {totalProduct,totalOrder,totalCategory,categoryList,categoryLoading,productList,productLoading,
      availableProductList,availableProductLoading, emptyStockProductList,emptyStockProductLoading,
      offerProductList,offerProductLoading,searchProductList,orderLoading,orderList
      }) {


    return AppState(
      totalProduct: totalProduct ?? this.totalProduct,
      totalOrder: totalOrder ?? this.totalOrder,
      totalCategory: totalCategory ?? this.totalCategory,
      categoryList: categoryList ?? this.categoryList,
      categoryLoading: categoryLoading ?? this.categoryLoading,
      productList: productList ?? this.productList,
      productLoading: productLoading ?? this.productLoading,
      availableProductList: availableProductList ?? this.availableProductList,
      availableProductLoading: availableProductLoading ?? this.availableProductLoading,
      emptyStockProductList: emptyStockProductList ?? this.emptyStockProductList,
      emptyStockProductLoading: emptyStockProductLoading ?? this.emptyStockProductLoading,
      offerProductList: offerProductList ?? this.offerProductList,
      offerProductLoading: offerProductLoading ?? this.offerProductLoading,
      searchProductList: searchProductList ?? this.searchProductList,
      orderLoading: orderLoading ?? this.orderLoading,
      orderList: orderList ?? this.orderList,
     
    );
  }
}
