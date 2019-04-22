//
//  ViewController.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/11.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "PsdRootModel.h"
#import "PsdControlTool.h"
#import "PsdFileTool.h"
#import "PsdDataTool.h"
// 控件
#import "PsdImageContentView.h"
#import "PsdControlInfoView.h"
#import "PsdJsonCellView.h"
#import "PsdJsonOutlineView.h"
#import "PsdPackView.h"

@interface ViewController()<WKScriptMessageHandler,NSOutlineViewDelegate, NSOutlineViewDataSource>
@property (strong) WKWebView *wkWebView;
@property (weak) IBOutlet PsdJsonOutlineView *outlineView;
// 资源图片控件，方便右面截图
@property (nonatomic, strong) NSImageView *sourceImageView;
// 图片内容控件
@property (nonatomic, strong) PsdImageContentView *imageContentView;
// 选中的根节点
@property (nonatomic, weak) PsdChildModel *selectedRootChildModel;
/** 文字内容*/
@property (nonatomic, strong) NSTextView *reseultTextView;
/** 控件内容*/
@property (nonatomic, strong) PsdControlInfoView *controlInfoView;
/** 内容容器*/
@property (nonatomic, strong) NSView *containerView;
/** 滚动*/
@property (nonatomic, strong) NSScrollView *scrollView;
/** 痰喘*/
@property (nonatomic, strong) PsdPackView *packView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    self.outlineView.allowsMultipleSelection = YES;
    WeakSelf_Psd
    self.outlineView.packBlock = ^(id object) {
        weakSelf.packView.controlModelArray = object;
    };
}

- (void)prepareUI
{
    [self prepareWebView];
    
    [self prepareContainerView];
    
    [self prepareSourceImageView];
}

- (void)prepareWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userVC = [[WKUserContentController alloc] init];
    [userVC addScriptMessageHandler:self name:@"getInfo"];
    config.userContentController = userVC;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.right.equalTo(self.view);
        make.left.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
    
    // Do any additional setup after loading the view.
    NSString *url = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"html"];
    NSURL *fileUrl = [NSURL fileURLWithPath:url];
    NSURLRequest *filrUrlRequest = [NSURLRequest requestWithURL:fileUrl];
    [self.wkWebView loadRequest:filrUrlRequest];
}

- (void)prepareSourceImageView
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"home" ofType:@"psd"]];
    NSImage *image = [[NSImage alloc] initWithData:data];
    NSImageView *sourceImageView = [[NSImageView alloc] init];
    sourceImageView.image = image;
    [self.view addSubview:sourceImageView];
    
    [sourceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
        make.left.equalTo(self.view.mas_right);
    }];
    self.sourceImageView = sourceImageView;
}

- (void)prepareContainerView
{
    NSView *containerView = [[NSView alloc] init];
    containerView.hidden = YES;
    [self.view addSubview:containerView];
    self.containerView = containerView;
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.outlineView.mas_right).offset(25);;
        make.top.bottom.right.equalTo(self.view);
    }];
    
    // 图片
    [containerView addSubview:self.imageContentView];
    [_imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.left.mas_equalTo(0);
        make.centerY.equalTo(containerView);
    }];
    
    // 控件
    [containerView addSubview:self.controlInfoView];
    [self.controlInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(containerView);
        make.width.mas_equalTo(275);
    }];
    
    [containerView addSubview:self.reseultTextView];
    [self.reseultTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageContentView.mas_right).offset(15);
        make.right.equalTo(self.controlInfoView.mas_left);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    
    NSScrollView *scrollView = [[NSScrollView alloc] init];
    [scrollView setDocumentView:self.reseultTextView];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [containerView addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageContentView.mas_right).offset(15);
        make.right.equalTo(self.controlInfoView.mas_left);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}

- (PsdImageContentView *)imageContentView
{
    if (!_imageContentView) {
        NSArray *array = nil;
        [[NSBundle mainBundle] loadNibNamed:@"PsdImageContentView" owner:nil topLevelObjects:&array];
        for (id object in array) {
            if ([object isKindOfClass:[PsdImageContentView class]]) {
                _imageContentView = object;
                break;
            }
        }
    }
    return _imageContentView;
}

- (PsdPackView *)packView
{
    if (!_packView) {
        NSArray *array = nil;
        [[NSBundle mainBundle] loadNibNamed:@"PsdPackView" owner:nil topLevelObjects:&array];
        for (id object in array) {
            if ([object isKindOfClass:[PsdPackView class]]) {
                _packView = object;
                WeakSelf_Psd
                _packView.submitBlock = ^(NSMutableArray *controlModelArray) {
                    
                };
                [self.view addSubview:_packView];
                [_packView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(weakSelf.view);
                }];
                break;
            }
        }
    }
    return _packView;
}

- (NSTextView *)reseultTextView
{
    if (!_reseultTextView) {
        
        _reseultTextView = [[NSTextView alloc] init];
        _reseultTextView.backgroundColor = [NSColor redColor];
        _reseultTextView.maxSize = NSMakeSize(FLT_MAX, FLT_MAX);
        [_reseultTextView setAutoresizingMask:NSViewHeightSizable];
        [[_reseultTextView textContainer]setContainerSize:NSMakeSize(FLT_MAX, FLT_MAX)];
        [[_reseultTextView textContainer]setHeightTracksTextView:YES];
        [self.view addSubview:_reseultTextView];
    }
    return _reseultTextView;
}

- (PsdControlInfoView *)controlInfoView
{
    if (!_controlInfoView) {
        NSArray *array = nil;
        [[NSBundle mainBundle] loadNibNamed:@"PsdControlInfoView" owner:nil topLevelObjects:&array];
        for (id object in array) {
            if ([object isKindOfClass:[PsdControlInfoView class]]) {
                _controlInfoView = object;
                WeakSelf_Psd
                _controlInfoView.changeValNameBlock = ^(id object) {
                    [weakSelf updateTextWithChildModel:object];
                };
                break;
            }
        }
    }
    return _controlInfoView;
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [PsdFileTool deleteRootDirectory];
    [[PsdDataTool sharedTool] setupWithJsonDict:message.body];
    [self.outlineView reloadData];
    [self.wkWebView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
}

#pragma mark - NSOutlineView数据源
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if ([item isKindOfClass:[PsdRootModel class]] || !item) {
        return [PsdDataTool sharedTool].dataModel.children.count;
    }
    return ((PsdChildModel *)item).children.count;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if ([item isKindOfClass:[PsdRootModel class]]) {
        return YES;
    }
    return ((PsdChildModel *)item).children.count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item
{
    if ([item isKindOfClass:[PsdRootModel class]] || !item) {
        return [PsdDataTool sharedTool].dataModel.children[index];
    }
    return ((PsdChildModel *)item).children[index];
}

#pragma mark - NSOutlineView代理
- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item
{
//    NSTableCellView *view = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    PsdJsonCellView *view = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    if ([item isKindOfClass:[PsdChildModel class]]) {
        [view.textField setStringValue:((PsdChildModel *)item).name];
    }
    return view;
}

// 选中改变通知
- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    NSOutlineView *outlineView = (NSOutlineView *)notification.object;
    NSLog(@"selectcols = %zd",outlineView.selectedRowIndexes.count);
    PsdChildModel *selectedModel = [outlineView itemAtRow:[outlineView selectedRow]];
    if (!selectedModel) {
        return;
    }
    self.containerView.hidden = NO;
    PsdChildModel *rootModel = selectedModel;
    // 判断是否是跟节点
    if (selectedModel.isRootModel) {
        
    } else {
        rootModel = selectedModel.rootChildModel;
    }
    // 更新代码
    [self updateTextWithChildModel:selectedModel];
    self.imageContentView.model = selectedModel;
    NSImage *image = [[NSImage alloc] initWithData:[self.sourceImageView dataWithPDFInsideRect:CGRectMake(0, self.sourceImageView.frame.size.height - rootModel.bottom, rootModel.width, rootModel.height)]];
    self.imageContentView.image = image;
    self.controlInfoView.childModel = selectedModel;
//    if (selectedModel.isLayer) {
//        self.controlInfoView.model = [[PsdDataTool sharedTool] subControlModelWithChildModel:selectedModel];
//    } else {
//        self.controlInfoView.model = [PsdDataTool sharedTool].customControlDict[selectedModel.name];
//    }
    self.controlInfoView.model = [[PsdDataTool sharedTool] controlModelWithChildModel:selectedModel];
}

- (void)updateTextWithChildModel:(PsdChildModel *)childModel
{
    NSString *msg = [PsdControlTool createControlWithModel:childModel];
    CGSize size = [msg boundingRectWithSize:NSMakeSize(self.scrollView.frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.reseultTextView.font}].size;
    [self.reseultTextView setString:msg];
    [self.reseultTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height + 5000);
        make.width.equalTo(self.scrollView);
    }];
}

@end
