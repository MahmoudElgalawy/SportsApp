import UIKit

class AllSportsVC: UIViewController {
    let networkManger = NWService.shared

    @IBOutlet var btnOrthogonal: UIBarButtonItem!
    @IBOutlet var sportsCV: UICollectionView!

    var isorthogonal = true
    let sportsItems = [
        SportsItemModel(imgName: "football", titleName: "Football"),
        SportsItemModel(imgName: "basketball", titleName: "Basketball"),
        SportsItemModel(imgName: "cricket", titleName: "Cricket"),
        SportsItemModel(imgName: "tennis", titleName: "Tennis")
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationItem.backBarButtonItem?.title = ""
    }

    // MARK: - Setup Methods
    private func setupCollectionView() {
        sportsCV.register(UINib(nibName: "AllSportsCell", bundle: nil), forCellWithReuseIdentifier: "AllSportsCell")
        sportsCV.delegate = self
        sportsCV.dataSource = self
    }


    @IBAction func sortingBtnPressed(_ sender: UIBarButtonItem) {
        isorthogonal.toggle()
        btnOrthogonal.image = UIImage(systemName: isorthogonal ? ("square.grid.2x2"):("list.bullet"))
        sportsCV.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension AllSportsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllSportsCell", for: indexPath) as? AllSportsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: sportsItems[indexPath.row])
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension AllSportsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isorthogonal {
            let numberOfCellsInRow: CGFloat = 2
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 10

            let collectionViewWidth = collectionView.bounds.width

            let spacingBetweenCells = flowLayout.minimumInteritemSpacing * (numberOfCellsInRow - 1)

            let adjustedWidth = collectionViewWidth - spacingBetweenCells
            let width = adjustedWidth / numberOfCellsInRow
            return CGSize(width: width - 10, height: width)
        } else{
            let collectionView = collectionView.bounds

            return CGSize(width: collectionView.width, height: collectionView.height/2)

        }
    }}


// MARK: - UICollectionViewDelegate
extension AllSportsVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("Cell selected at index: \(indexPath.row)")

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SportTV") as! LeaguesTV
       self.navigationController?.pushViewController(vc, animated: true)

//
    }
}
