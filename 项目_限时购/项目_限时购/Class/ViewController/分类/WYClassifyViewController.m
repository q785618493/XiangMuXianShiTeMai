//
//  WYClassifyViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYClassifyViewController.h"
#import "WYDetailsClassfyViewController.h"

#import "WYFaceCollection.h"

#import "WYSortModel.h"
#import "WYFaceModel.h"

@interface WYClassifyViewController ()

/** 展示视图信息的 CollectionView*/
@property (strong, nonatomic) WYFaceCollection *faceCollectionView;

/** 保存数据信息的 */
@property (strong, nonatomic) NSMutableArray *muFaceArray;

@end

@implementation WYClassifyViewController

/** 重写get方法 懒加载 */
- (NSMutableArray *)muFaceArray {
    if (!_muFaceArray) {
        _muFaceArray = [NSMutableArray array];
    }
    return _muFaceArray;
}

- (WYFaceCollection *)faceCollectionView {
    if (!_faceCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
        
        _faceCollectionView = [[WYFaceCollection alloc] initWithFrame:(CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)) collectionViewLayout:flowLayout];
    }
    return _faceCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 添加UI控件 和 约束 */
    [self controlAddMasonry];
    
   /** 用NSBlockOperation 将网络请求按自定义顺序返回 (失败)*/
    [self blockTaskOperationRequestData];
    
}

/** 添加UI控件 和 约束 */
- (void)controlAddMasonry {

    [self.view addSubview:self.faceCollectionView];
    
    WS(weakSelf);
    [_faceCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    weakSelf.faceCollectionView.collCellRow = ^(NSIndexPath *collIndex) {
      
        WYDetailsClassfyViewController *detailsVC = [[WYDetailsClassfyViewController alloc] init];
        
        if (0 == collIndex.section) {
            WYSortModel *model = weakSelf.muFaceArray[collIndex.section][collIndex.row];
            detailsVC.start = NO;
            detailsVC.typeID = model.goodsType;
            detailsVC.title = model.goodsTypeName;
        }
        else {
            
            WYFaceModel *model = weakSelf.muFaceArray[collIndex.section][collIndex.row];
            detailsVC.start = YES;
            detailsVC.typeID = model.shopId;
            detailsVC.judgeRequest = 1;
            detailsVC.title = model.commodityText;
        }
        
        [weakSelf.navigationController pushViewController:detailsVC animated:YES];
    };
    
    
    
    
}

/** 用NSBlockOperation 将网络请求按自定义顺序返回 */
- (void)blockTaskOperationRequestData {
    __weak typeof(self) weakSelf = self;
    /** 添加网络请求获取展示数据 */
    NSBlockOperation *classfyOperation = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf httpGetClassfyRequest];
    }];
    
    NSBlockOperation *faceOperacion = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf httpGetFaceRequest];
        });
        
    }];
    
    NSBlockOperation *bodyOperation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf httpGetBodyRequest];
        });
    }];
    
    NSBlockOperation *brandOperation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf httpGetBrandRequest];
        });
        
    }];
    
    /** 关联依赖 */
    [faceOperacion addDependency:classfyOperation];
    [bodyOperation addDependency:faceOperacion];
    [brandOperation addDependency:bodyOperation];
    
    /** 创建队列，将任务加入 */
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:classfyOperation];
    [queue addOperation:faceOperacion];
    [queue addOperation:bodyOperation];
    [queue addOperation:brandOperation];
}

/** 功效区接口网络请求 */
- (void)httpGetClassfyRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appBrandareatype/findBrandareatype.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count >= 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                WYSortModel *model = [[WYSortModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.muFaceArray addObject:muArray];
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"失败==%@",error);
    }];
}

/** 面部专区的网络请求 */
- (void)httpGetFaceRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appBrandarea/asianBrand.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count >= 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYFaceModel *model = [[WYFaceModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.muFaceArray addObject:muArray];
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"失败==%@",error);
    }];
}

/** 身体专区的网络请求 */
- (void)httpGetBodyRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appBrandarea/europeanBrand.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count >= 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYFaceModel *model = [[WYFaceModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.muFaceArray addObject:muArray];
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"失败==%@",error);
    }];
}

/** 品牌专区的网络请求 */
- (void)httpGetBrandRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appBrandareanew/findBrandareanew.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count >= 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYFaceModel *model = [[WYFaceModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.muFaceArray addObject:muArray];
            
            weakSelf.faceCollectionView.collArray = weakSelf.muFaceArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.faceCollectionView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"失败==%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
