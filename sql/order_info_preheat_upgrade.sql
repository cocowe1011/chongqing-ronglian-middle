-- 二期工程：上货流程改造，订单增加“预热房编号”“预热时间”字段
-- 已有库升级脚本：为 order_info 增加 preheat_room、preheat_time 两列（幂等）

IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.order_info')
      AND name = N'preheat_room'
)
BEGIN
    ALTER TABLE dbo.order_info ADD preheat_room NVARCHAR(50) NULL;
END
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.order_info')
      AND name = N'preheat_time'
)
BEGIN
    ALTER TABLE dbo.order_info ADD preheat_time DECIMAL(10,1) NULL;
END
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预热房编号（编号1~12）', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'order_info', @level2type=N'COLUMN', @level2name=N'preheat_room';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预热时间（单位：小时，支持一位小数）', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'order_info', @level2type=N'COLUMN', @level2name=N'preheat_time';
GO
