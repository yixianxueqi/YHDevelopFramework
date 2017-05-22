//
//  YHTools.h
//  YHDevelopFramework
//
//  Created by 君若见故 on 16/7/19.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#ifndef YHTools_h
#define YHTools_h

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

//弱引用
#define weakObj(obj) __weak typeof(obj) weak##obj = obj
//强引用
#define strongObj(obj) __strong typeof(obj) obj = weak##obj

//判断系统是否是大于8.0
#define IOS_8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0?YES:NO
//判断系统是否是大于9.0
#define IOS_9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0?YES:NO

//设置颜色
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//设置16进制颜色s
#define XColor(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

//沙盒写数据
#define sanBoxStore(key,value) [[NSUserDefaults standardUserDefaults] setValue:(value) forKey:(key)]
//沙盒取数据
#define sanBoxTake(key) [[NSUserDefaults standardUserDefaults] valueForKey:(key)]
//读取本地图片
#define localImage(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
//从plist获取字典
#define dicFromePlist(name) [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:@"plist"]]
//从plist获取数组
#define listFromPlist(name) [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:@"plist"]]
//从json文件获取字典
#define dicFromJSON(name) [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:@"json"]] options:NSJSONReadingAllowFragments error:nil]


//读取xib
#define nibView(viewClass) [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([viewClass class]) owner:self options:nil].lastObject
//注册tableViewCell，class
#define regClsCellT(tableView,cls,identifier) [(tableView) registerClass:(cls) forCellReuseIdentifier:(identifier)]
//注册tableViewCell,nib
#define regNibCellT(tableView,nibName,identifier) [(tableView) registerNib:[UINib nibWithNibName:(nibName) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:(identifier)]
//注册collectionViewCell,class
#define regClsCellC(collectionView,cls,identifier) [(collectionView) registerClass:cls forCellWithReuseIdentifier:identifier]
//注册collectionViewCell,nib
#define regNibCellC(collectionView,nibName,identifier)   [(collectionView) registerNib:[UINib nibWithNibName:(nibName) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:(identifier)]


#define isNullString(obj) 

#endif /* YHTools_h */
